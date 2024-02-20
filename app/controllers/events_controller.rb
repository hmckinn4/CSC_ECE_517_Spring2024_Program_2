class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :delete_session, only: %i[ show destroy index]
  before_action :authorization_admin_only, only: %i[ new edit update destroy ]


  # GET /events or /events.json
  def index
    # Filter for events with available seats.
    @events = Event.all
    # Filter for upcoming events.
    @events = @events.filter_by_upcoming if params[:upcoming] == 'on'
    # Filter for events with available seats.
    @events = @events.filter_by_availability if params[:available] == 'on'
    # Filter by category if specified.
    @events = @events.filter_by_category(params[:category]) if params[:category].present? && params[:category] != ''
    # Filter by date if specified.
    @events = @events.filter_by_date(params[:date]) if params[:date].present?
    # Filter by price range if specified.
    @events = @events.filter_by_price_range(params[:min_price], params[:max_price]) if params[:min_price].present? && params[:min_price] != '' && params[:max_price].present? && params[:max_price] != ''
    # Filter by event name if specified.
    @events = @events.filter_by_name(params[:name]) if params[:name].present? && params[:name] != ''
    # Get unique event names for the filter dropdown.
    @event_names = Event.pluck(:name).uniq
    # Gather the dates from events.
    @event_dates = Event.order(:date).pluck(:date).uniq

  end

  def authorization_admin_only
    unless admin_signed_in?
      redirect_to root_path, alert: "Only admin can access this page."
    end
  end


def delete_session
  session.delete(:date)
  session.delete(:start_time)
  session.delete(:end_time)
  session.delete(:available_rooms)
  session.delete(:checked)
end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new(event_params)
    if session[:available_rooms]
      @available_rooms = Room.find(session[:available_rooms])
    end
    # Initially pass all rooms, later to be filtered by JS
    # @available_rooms = Room.all
  end

  # GET /events/1/edit
  def edit
    # For edit, we might want to calculate the available rooms based on the event's date and times
    # @available_rooms = Room.available_for(start: @event.start_time, end: @event.end_time)
    if session[:available_rooms_edit]
      @available_rooms = Room.find(session[:available_rooms_edit])
    end
    # Initially pass all rooms, later to be filtered by JS
    # @available_rooms = Room.all
  end

  # def available_rooms
  #   start_time = DateTime.parse("#{params[:date]} #{params[:start_time]}")
  #   end_time = DateTime.parse("#{params[:date]} #{params[:end_time]}")
  #   @available_rooms = Room.available_for(start: start_time, end: end_time)
  #   render json: @available_rooms
  # end

  # POST /events or /events.json
  def create
    required_params = params[:event].slice(:name, :date, :start_time, :end_time, :room_id, :seats_left)
    if required_params.values.any?(&:blank?)
      flash.now[:alert] = 'Please fill all the fields'
      redirect_to new_event_path, alert: "Please fill all the fields."
      return
    end
    if params[:check_rooms]
      date = params[:event][:date]
      start_time = Time.parse(params[:event][:start_time])
      end_time = Time.parse(params[:event][:end_time])
      session[:date] = date
      session[:start_time] = params[:event][:start_time]
      session[:end_time] = params[:event][:end_time]
      session[:check] = true
      @available_rooms = available_rooms(date, start_time, end_time)
    elsif params[:create_event]
      @event = Event.new(event_params)
      room = Room.find_by(id: @event.room_id)
      seats_left = params[:event][:seats_left].to_i
      if seats_left < 0 || seats_left > room.capacity
        flash.now[:alert] = 'Invalid number of seats left.'
        redirect_to new_event_path, alert: "Invalid number of seats left."
        return
      end
      @event.seats_left = seats_left
      if @event.save
        session.delete(:date)
        session.delete(:start_time)
        session.delete(:end_time)
        session.delete(:available_rooms)
        session.delete(:checked)
        redirect_to @event, notice: "Event was successfully created."
      else
        render new
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @event = Event.find(params[:id])
    required_params = params[:event].slice(:name, :date, :start_time, :end_time, :room_id, :seats_left)
    if required_params.values.any?(&:blank?)
      flash.now[:alert] = 'Please fill all the fields'
      redirect_to edit_event_path, alert: "Please fill all the fields."
      return
    end
    if params[:check_rooms_edit]
      print(params)
      date = params[:event][:date]
      start_time = Time.parse(params[:event][:start_time])
      end_time = Time.parse(params[:event][:end_time])
      session[:date] = date
      session[:start_time] = params[:event][:start_time]
      session[:end_time] = params[:event][:end_time]
      session[:check] = true
      @available_rooms = available_rooms_edit(date, start_time, end_time)
    else
      if @event.update(event_params)
        room = Room.find_by(id: @event.room_id)
        seats_left = params[:event][:seats_left].to_i
        if seats_left < 0 || seats_left > room.capacity
          flash.now[:alert] = 'Invalid number of seats left.'
          redirect_to edit_event_path, alert: "Invalid number of seats left."
          return
        end
        @event.seats_left = seats_left
        session.delete(:date)
        session.delete(:start_time)
        session.delete(:end_time)
        session.delete(:available_rooms_edit)
        session.delete(:checked)
        redirect_to @event, notice: "Event was successfully updated."
      else
        render edit
      end
    end
  end
  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  #
  def available_rooms(date, start_time, end_time)
    @available_rooms = nil
    # date = params[:date]
    # start_time = Time.parse(params[:start_time])
    # end_time = Time.parse(params[:end_time])
    start_time_seconds = start_time.seconds_since_midnight
    end_time_seconds = end_time.seconds_since_midnight

    event_on_the_same_day = Event.where(date: date)
    event_conflicted = event_on_the_same_day.select do |event|
      (event.start_time.seconds_since_midnight <= end_time_seconds && event.end_time.seconds_since_midnight >= start_time_seconds) ||
        (event.start_time.seconds_since_midnight >= start_time_seconds && event.end_time.seconds_since_midnight <= end_time_seconds)
    end

    conflicted_room_id = []
    event_conflicted.select do |event|
      conflicted_room_id.append(event.room_id)
    end
    @available_rooms = Room.all.select do |room|
      not conflicted_room_id.include?(room.id)
    end
    logger.info "@available_rooms: #{@available_rooms}"

    session[:available_rooms] = @available_rooms.map(&:id)

    redirect_to new_event_path

  end

  def available_rooms_edit(date, start_time, end_time)
    @available_rooms = nil
    # date = params[:date]
    # start_time = Time.parse(params[:start_time])
    # end_time = Time.parse(params[:end_time])
    start_time_seconds = start_time.seconds_since_midnight
    end_time_seconds = end_time.seconds_since_midnight

    event_on_the_same_day = Event.where(date: date)
    logger.info "@event_on_the_same_day: #{event_on_the_same_day}"
    event_conflicted = event_on_the_same_day.select do |event|
      (event.start_time.seconds_since_midnight <= end_time_seconds && event.end_time.seconds_since_midnight >= start_time_seconds) ||
        (event.start_time.seconds_since_midnight >= start_time_seconds && event.end_time.seconds_since_midnight <= end_time_seconds)
    end

    conflicted_room_id = []
    event_conflicted.select do |event|
      conflicted_room_id.append(event.room_id)
      logger.info "@conflicted_room_id: #{event.room_id}"
    end
    @available_rooms = Room.all.select do |room|
      not conflicted_room_id.include?(room.id)
    end
    logger.info "@available_rooms: #{@available_rooms}"

    session[:available_rooms_edit] = @available_rooms.map(&:id)

    redirect_to edit_event_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.fetch(:event, {}).permit(:name, :category, :date, :start_time, :end_time, :ticket_price, :room_id, :seats_left)
    end
end

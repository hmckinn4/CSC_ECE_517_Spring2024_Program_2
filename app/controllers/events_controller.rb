class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]


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





  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    # Initially pass all rooms, later to be filtered by JS
    @available_rooms = Room.all
  end

  # GET /events/1/edit
  def edit
    # For edit, we might want to calculate the available rooms based on the event's date and times
    @available_rooms = Room.available_for(start: @event.start_time, end: @event.end_time)
  end

  def available_rooms
    start_time = DateTime.parse("#{params[:date]} #{params[:start_time]}")
    end_time = DateTime.parse("#{params[:date]} #{params[:end_time]}")
    @available_rooms = Room.available_for(start: start_time, end: end_time)
    render json: @available_rooms
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    room = Room.find_by(id: @event.room_id)
    @event.seats_left = room.capacity

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :room_id, :category, :date, :start_time, :end_time, :ticket_price)
    end
end

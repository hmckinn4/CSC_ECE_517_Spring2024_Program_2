class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]
  before_action :user_login!
  before_action :authorization_admin_only, only: [:index]


  def authorization_admin_only
    unless admin_signed_in?
      redirect_to root_path, alert: "Only admin can access this page."
    end
  end


  # GET /event_tickets or /event_tickets.json
  def index
    @event_tickets = EventTicket.all
  end

  # GET /event_tickets/1 or /event_tickets/1.json
  def show
  end

  # GET /event_tickets/new
  def new
    @event_ticket = EventTicket.new
  end

  # GET /event_tickets/1/edit
  def edit
  end

  def get_current_user_id
    if admin_signed_in?
      current_admin.id
    end
    if attendee_signed_in?
      current_attendee.id
    end
  end

  # POST /event_tickets or /event_tickets.json
  def create

    if params[:event_ticket].present?
      @event_ticket = EventTicket.new
      @event_ticket.event_id = params[:event_ticket][:event_id]
      @event = Event.find(params[:event_ticket][:event_id])
      @event_ticket.attendee_id = params[:event_ticket][:attendee_id]
      @event_ticket.confirmation_number = SecureRandom.hex(15)
      @event_ticket.room_id = @event.room_id
    else
      @event_ticket = EventTicket.new
      @event = Event.find(params[:format])
      @event_ticket.event_id = params[:format]
      @event_ticket.room_id = @event.room_id
      if attendee_signed_in?
        @event_ticket.attendee_id = current_attendee.id
      elsif admin_signed_in?
        @event_ticket.admin_id = current_admin.id
        @event_ticket.attendee_id = nil
      end
      @event_ticket.confirmation_number = SecureRandom.hex(15)
    end
    if @event.date < Date.today || (@event.date == Date.today && @event.start_time < Time.now)
      redirect_to @event, notice: 'Event has already passed.'
      return
    end
    if @event.seats_left <= 0
      redirect_to @event, notice: 'Event has no seat left.'
      return
    end

    if @event_ticket.save
      @event.minus_seats_left
      redirect_to @event_ticket, notice: 'Ticket successfully booked.'
    else
      Rails.logger.debug @event_ticket.errors.full_messages
      redirect_to @event, alert: 'Unable to book ticket.'
    end

  end

  # PATCH/PUT /event_tickets/1 or /event_tickets/1.json
  def update
    respond_to do |format|
      if @event_ticket.update(event_ticket_params)
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @event_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_tickets/1 or /event_tickets/1.json
  def destroy
    @event = @event_ticket.event
    @event_ticket.destroy

    respond_to do |format|
      format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      format.json { head :no_content }
    end

    @event.add_seats_left
  end

  private

  def user_login!
    unless admin_signed_in? or attendee_signed_in?
      redirect_to root_path, alert: "Please login first"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_ticket
      @event_ticket = EventTicket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_ticket_params
      params.require(:event_ticket).permit
    end
end

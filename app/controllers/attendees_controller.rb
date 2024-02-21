class AttendeesController < ApplicationController
  before_action :set_attendee, only: %i[ show edit update destroy ]
  before_action :authorization_admin_only, only: [:index]
  before_action :only_allow_current_attendee, only: [:booked_events, :order_history, :edit]
  before_action :check_access, only: [:new]

  # GET /attendees or /attendees.json
  def index
    @attendees = Attendee.all
  end

  # GET /attendees/1 or /attendees/1.json
  def show
  end



  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit
  end

  # POST /attendees or /attendees.json
  def create
    @attendee = Attendee.new(attendee_params)

    respond_to do |format|
      if @attendee.save
        if admin_signed_in?
          format.html { redirect_to attendees_path, notice: "Attendee was successfully created." }
          format.json { render :show, status: :created, location: @attendee }
        else
          format.html { redirect_to attendee_url(@attendee), notice: "Attendee was successfully created." }
          format.json { render :show, status: :created, location: @attendee }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendees/1 or /attendees/1.json
  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to attendee_url(@attendee), notice: "Attendee was successfully updated." }
        format.json { render :show, status: :ok, location: @attendee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendees/1 or /attendees/1.json
  def destroy
    @attendee.destroy

    respond_to do |format|
      format.html { redirect_to attendees_url, notice: "Attendee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def booked_events
    @attendee = Attendee.find(params[:id])
    @events = @attendee.events
    @event_tickets = @attendee.event_tickets
  end

  def order_history
    @order_histories = EventTicket.where(buyer: current_attendee) || EventTicket.none
    @name = current_attendee.name
  end

  private

  def authorization_admin_only
    unless admin_signed_in?
      redirect_to root_path, alert: "Only admin can access this page."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

  def only_allow_current_attendee
    requested_attendee = Attendee.find(params[:id])
    unless current_attendee == requested_attendee
      redirect_to current_attendee, alert: "You are not authorized to view this page."
    end
  end

    # Only allow a list of trusted parameters through.
    def attendee_params
      params.require(:attendee).permit(:email, :name, :phone_number, :address, :credit_card_info)
    end

  # Define a method to check if the user is authorized to access the new action
  def check_access
    unless admin_or_unregistered?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  # Helper method to determine if the user is an admin or not registered
  def admin_or_unregistered?
    current_attendee.nil? || admin_signed_in?
  end
end

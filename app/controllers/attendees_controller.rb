class AttendeesController < ApplicationController
  # Add before_action to authenticate and to verify that only attendees access.
  before_action :authenticate_user!
  before_action :attendee_valid?

  def home
    # Customize with relevant data for the admin dashboard.
  end

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
        format.html { redirect_to attendee_url(@attendee), notice: "Attendee was successfully created." }
        format.json { render :show, status: :created, location: @attendee }
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

  private

  # Allow only registered attendees to access attendee homepage.
  def attendee_valid?
    unless current_user.is_a?(Attendee)
      redirect_to root_path, alert: "Access is limited to registered attendees."
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendee_params
      params.require(:attendee).permit(:email, :password, :name, :phone_number, :address, :credit_card_info)
    end
end

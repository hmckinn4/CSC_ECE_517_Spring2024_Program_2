class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin, only: %i[ show edit update destroy ]

  # GET /admins or /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1 or /admins/1.json
  def show
    # Assuming @admin is set by set_admin callback
    # This line provides the event names for the dropdown
    @event_names = Event.order(:name).pluck(:name).uniq
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # Function that sear
  def search_attendees
    @event_names = Event.order(:name).pluck(:name).uniq
    if params[:event_name].present?
      # Find the event by name
      event = Event.find_by(name: params[:event_name])
      if event
        # Get all attendees for this event
        @attendees = event.attendees_ids
      else
        flash[:alert] = "Event not found"
        @attendees = []
      end
    else
      flash[:alert] = "Please enter an event name"
      @attendees = []
    end
  end
  # POST /admins or /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
  # Should not be able to destroy the administrator
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:email, :password, :name, :phone_number, :address, :credit_card_info)
    end
end

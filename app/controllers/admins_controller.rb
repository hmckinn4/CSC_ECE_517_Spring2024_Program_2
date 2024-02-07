class AdminsController < ApplicationController
  # Ensure user is logged in and is an admin.
  before_action :authenticate_user!
  before_action :admin_valid?
  # Define a before_action to set the admin for the edit and update actions.
  before_action :set_admin, only: [:edit, :update]

  # Home action for admin dashboard.
  def home
    # Customize with relevant data for the admin dashboard.
  end

  # GET /admins or /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1 or /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # Dont think we need a create method since admin info pre-configured.

  # POST /admins or /admins.json
  # def create
  #   @admin = Admin.new(admin_params)
  #
  #   respond_to do |format|
  #     if @admin.save
  #       format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
  #       format.json { render :show, status: :created, location: @admin }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @admin.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /admins/1 or /admins/1.json
  # def update
  #   respond_to do |format|
  #     if @admin.update(admin_params)
  #       format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
  #       format.json { render :show, status: :ok, location: @admin }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @admin.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    # If admin profile is successfully updated
    if @admin.update(admin_params)
      # Success message
      flash[:success] = "Profile updated successfully"
      # Redirect to admin homepage
      redirect_to admin_homepage_path
    else
      # Render edit page again with errors if update fails
      render :edit
    end
  end

  # Admin can't be deleted so method is commented out.

  # DELETE /admins/1 or /admins/1.json
  # def destroy
  #   @admin.destroy
  #
  #   respond_to do |format|
  #     format.html { redirect_to admins_url, notice: "Admin was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Ensures that only the admin can access the administrator homepage.
  def admin_valid?
    unless current_user.is_a?(Admin)
      redirect_to root_path, alert: "Denied: Only the admin can access the administrator homepage."
    end
    # Use callbacks to share common setup or constraints between actions.
    # def set_admin
    #   @admin = Admin.find(params[:id])
    # end

    # Set the current user as the admin for editing and updating
      def set_admin
        @admin = current_user
      end

    # Only allow a list of trusted parameters through.
    # Define allowed parameters for admin update
    def admin_params
      # Permit only specified attributes for admin update.
      params.require(:admin).permit(:name, :phone_number, :address, :credit_card_info)
    end
  end
end

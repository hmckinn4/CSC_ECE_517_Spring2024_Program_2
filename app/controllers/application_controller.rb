class ApplicationController < ActionController::Base
  before_action :registration_check, if: :devise_controller?
  before_action :prevent_dual_sign_in
  protected
  def registration_check
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :address, :credit_card_info, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number, :address, :credit_card_info, :password, :password_confirmation])
  end

  def prevent_dual_sign_in
    if admin_signed_in? && attendee_signed_in?
      sign_out(:attendee)
    end
  end

  # Determines the redirection path after sign-in based on the user's role.
  def after_sign_in_path_for(user)
    if user.is_a?(Admin)
      current_admin
    elsif user.is_a?(Attendee)
      current_attendee
    else
      super
    end
  end

  def after_sign_up_path_for(user)

    if user.is_a?(Admin)
      current_admin
    # elsif user.is_a?(Attendee) && admin_signed_in?
    #   current_admin
    elsif user.is_a?(Attendee)
      current_admin
    else
      root_path
    end
  end
end

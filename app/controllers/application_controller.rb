# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :add_user_specs, if: :devise_controller?


  protected
  def add_user_specs
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type, :name, :phone_number, :address, :credit_card_info])
  end

  # Determines the redirection path after sign-in based on the user's role.
  def after_sign_in_path_for(user)
    # Checks if the signed-in user is an Admin.
    if user.is_a?(Admin)
      # Directs admins to the administrator homepage for administrative tasks.
      admin_homepage_path
      # Checks if the signed-in user is an attendee.
    elsif user.is_a?(Attendee)
      # Leads attendees to their homepage where they can explore events.
      attendee_homepage_path
    else
      # Utilizes the default Devise behavior for any other user types.
      super
    end
  end
end

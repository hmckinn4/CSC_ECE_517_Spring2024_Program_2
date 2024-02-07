class ApplicationController < ActionController::Base
  protected
  def add_user_specs
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type, :name, :phone_number, :address, :credit_card_info])
  end

  # Determines the redirection path after sign-in based on the user's role.
  def after_sign_in_path_for(user)
    # Checks if the signed-in user is an Admin.
    if user.is_a?(Admin)
      # Directs admins to the administrator homepage for administrative tasks.
      current_admin
      # Checks if the signed-in user is an attendee.
    elsif user.is_a?(Attendee)
      # Leads attendees to their homepage where they can explore events.
      current_attendee
    else
      # Utilizes the default Devise behavior for any other user types.
      super
    end
  end
end

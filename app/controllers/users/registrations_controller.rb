# app/controllers/users/registrations_controller.rb

# This controller overrides the default Devise RegistrationsController to provide customized behavior during the user registration process.
class Users::RegistrationsController < Devise::RegistrationsController

  # Overrides the new action to set up a new user as an Attendee by default.
  # This ensures that all users signing up through the standard sign-up form are registered with the Attendee role.
  def new
    # Initializes the user as an Attendee.
    build_resource(type: 'Attendee')
    # Yields the new resource to a block, if given, for additional setup.
    yield resource if block_given?
    # Responds with the newly built resource, utilizing the appropriate Devise views.
    respond_with resource
  end

  # Overrides the create action to customize the user registration process.
  def create
    # Builds a new user resource with the parameters from the sign-up form.
    build_resource(sign_up_params)

    # Explicitly sets the user type to 'Attendee' to enforce STI inheritance.
    resource.type = 'Attendee'

    # Attempts to save the new user to the database.
    resource.save
    # Yields the resource to a block, if given, which allows for additional processing.
    yield resource if block_given?
    # Checks if the user was successfully persisted to the database.
    if resource.persisted?
      # Checks if the user is ready for sign-in.
      if resource.active_for_authentication?
        # Sets a flash message to indicate successful sign-up.
        set_flash_message! :notice, :signed_up
        # Signs in the user and redirects to the specified post-sign-up path.
        sign_up(resource_name, resource)
        # Responds with the resource, directing the user to the after_sign_up_path.
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        # Sets a flash message to indicate the user is signed up but not active.
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        # Expires session data after sign-in to prevent unauthorized access.
        expire_data_after_sign_in!
        # Responds with the resource, redirecting to the new session path for further action.
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      # Cleans up the password fields in the event of a failed sign-up.
      clean_up_passwords resource
      # Sets the minimum password length to be used in the sign-up view.
      set_minimum_password_length
      # Responds with the invalid resource to re-render the sign-up form.
      respond_with resource
    end
  end

  # Customizes the sign-up parameters to include additional user attributes.
  # This method adds extra parameters to the default list allowed by Devise during registration.
  def configure_sign_up_params
    # Permits additional attributes for user sign-up, ensuring they are saved along with the standard Devise fields.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type, :name, :phone_number, :address, :credit_card_info])
  end

  # Specifies the path to be used after a successful sign-up.
  # This method overrides the default to redirect users to the attendee homepage specifically.
  def after_sign_up_path_for(resource)
    # Directs the user to the Attendee homepage upon successful registration.
    attendee_homepage_path
  end
end

Rails.application.routes.draw do
  # Define Devise routes for users with custom registrations controller
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Defines which controller action will handle requests to the root path.
  root to: "home#index"

  # Resource routes for the models
  resources :reviews
  resources :event_tickets
  resources :events
  resources :rooms

  # Route to handle editing and updating admin profiles
  resources :admins, only: [:edit, :update]

  # Routes for admin and attendee homepages.
  get 'admin_homepage', to: 'admins#home', as: :admin_homepage
  # get 'admins/:id/show', to: 'admins#home', as: :admin_homepage
  get 'attendee_homepage', to: 'attendees#home', as: :attendee_homepage

  # Routes for admin homepage buttons
  # Edit Profile




  # Might not need the resources :attendees and :admins lines since we're
  #   using STI and Devise for users.
  # If we decide on specific non-Devise controllers and actions for admins and attendees,
  #   we can uncomment these:

  # resources :attendees, only: [:index, :show, :edit, :update] # Specify only the actions you need.
  # resources :admins, only: [:index, :show, :edit, :update]

  # The default root path route ("/"), you've already defined root at the top
  # root "articles#index" # This is not necessary root path is already set.
end

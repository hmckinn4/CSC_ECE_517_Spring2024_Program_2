Rails.application.routes.draw do
  get 'login/index'
  devise_for :attendees
  devise_for :admins
  resources :reviews
  resources :event_tickets
  resources :events do
    get 'available_rooms', on: :collection
  end
  resources :rooms
  resources :attendees
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "login#index"

  get 'attendees/:id/view_booked_events' => 'attendees#booked_events', :as => :booked_events

  # Route for admin to search for attendees by event name. This maps a GET request to the search_attendees action in the AdminsController.
  get 'admin/search_attendees', to: 'admins#search_attendees', as: 'search_attendees'

  # post 'events/available_rooms', to: 'events#available_rooms', as: 'available_rooms'

end


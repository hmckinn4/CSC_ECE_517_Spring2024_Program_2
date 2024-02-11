Rails.application.routes.draw do
  get 'login/index'
  devise_for :attendees
  devise_for :admins
  resources :reviews
  resources :event_tickets
  resources :events
  resources :rooms
  resources :attendees
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "login#index"

  get 'attendees/:id/view_booked_events' => 'attendees#booked_events', :as => :booked_events
end

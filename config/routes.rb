Rails.application.routes.draw do
  devise_for :users
  #defines which controller action will handle requests to the root path
  root to: "home#index"
  resources :reviews
  resources :event_tickets
  resources :events
  resources :rooms
  resources :attendees
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

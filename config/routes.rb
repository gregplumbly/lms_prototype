Rails.application.routes.draw do

  resource :session
  resources :passwords, param: :token
  resources :users, only: %i[new create]

  get "/", to: "home#show", as: :home
  get "/dashboard", to: "dashboard#index", as: :dashboard

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#show"

  resources :courses, only: %i[index show], param: :slug do
    resources :lessons, only: :show, param: :position
  end
end

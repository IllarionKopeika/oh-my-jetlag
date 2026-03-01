Rails.application.routes.draw do
  scope "(:locale)", locale: /ru|en/ do
    # sessions
    resource :session, only: :create
    get "login", to: "sessions#new", as: "login"
    delete "logout", to: "sessions#destroy", as: "logout"

    # change password
    get "change_password", to: "passwords#change_password", as: "change_password"
    patch "update_password", to: "passwords#update_password", as: "update_password"

    # users
    resources :users, only: :create
    get "sign_up", to: "users#new", as: "sign_up"
    get "profile", to: "users#show", as: "profile"

    # flights
    resources :flights, only: [ :index, :create ]
    root "flights#index"
    get "add", to: "flights#new", as: "add"
    get "search", to: "flights#search", as: "search"
    get "fetch_flight", to: "flights#fetch", as: "fetch_flight"
    get "map", to: "flights#map", as: "map"

    # airports
    resources :airports, only: [] do
      collection do
        get :search
      end
    end

    # aircrafts
    resources :aircrafts, only: [] do
      collection do
        get :search
      end
    end

    # countries
    resources :countries, only: [] do
      collection do
        get :search
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

Rails.application.routes.draw do
  scope '(:locale)', locale: /ru|en/ do
    root 'pages#home'
    get 'pages/home'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end

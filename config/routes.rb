Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resources :cats, only: :index
    resources :locations, only: :index
    resources :names, only: :index
  end

  get '*pages', to: 'home#index'
end

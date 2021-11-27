Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :health, only: :index

  namespace :api do
    namespace :v1 do
      resources :cats, only: %i[index]
    end
  end
end

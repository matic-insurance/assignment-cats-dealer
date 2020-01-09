Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'requests#new'

  resources :cats, only: %i[index]
  resources :requests, only: %i[create]
end

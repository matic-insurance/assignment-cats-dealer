Rails.application.routes.draw do
  root 'requests#index'

  resources :requests, only: %i[index]
  get 'get_kitties', to: 'requests#get_kitties'
end

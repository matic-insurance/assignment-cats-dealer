Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'

  post :cats, to: 'cats#search'
  resources :cats, only: %i[index]
  
end

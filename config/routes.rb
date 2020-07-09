Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'

  resource :request, only: %i[create new] do
    get :result
  end


  post :cats, to: 'cats#search'
  resources :cats, only: %i[new index] do
    get :result
  end
  
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#new'

  resource :request, only: %i[create new] do
    get :result
  end


  post :cats, to: 'cats#best_deal'
  resources :cats, only: %i[new] do

  end
  
end

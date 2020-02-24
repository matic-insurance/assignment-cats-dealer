Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'search#new'

  resources :search, only: %i[create new] do
    get :empty_result
    get :result
  end
end

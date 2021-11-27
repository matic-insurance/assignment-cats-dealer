Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :health, only: :index

  resource :request, only: %i[create] do
    get :result
  end
end

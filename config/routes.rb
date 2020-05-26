Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'

  resources :items, only: %i[index] do
    collection do
      get :index
    end
  end
end

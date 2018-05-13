Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'

  resource :cats, only: %i[index, count] do
    get :index
    get :count
  end
end

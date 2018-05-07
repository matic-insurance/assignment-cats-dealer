Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#search'

  resource :cats, only: %i[search] do
    get :search
  end
end

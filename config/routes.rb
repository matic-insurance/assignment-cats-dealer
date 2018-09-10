Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cat_stores#new'

  resource :cat_stores, only: %i[new] do
    post :result
  end
end

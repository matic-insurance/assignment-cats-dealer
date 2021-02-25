Rails.application.routes.draw do
  root 'cats#index'

  resource :cats, only: :index
end

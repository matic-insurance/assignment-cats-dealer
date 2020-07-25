Rails.application.routes.draw do
  root 'requests#new'

  resource :request, only: %i[new]
  resources :cats, only: %i[index]
end

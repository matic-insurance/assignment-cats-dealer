Rails.application.routes.draw do
  get 'cats', to: 'cats#index'
  root 'cats#index'
end

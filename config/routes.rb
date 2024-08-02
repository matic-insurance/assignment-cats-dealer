Rails.application.routes.draw do
  namespace :v1 do
    resources :cats, only: :index
  end
end

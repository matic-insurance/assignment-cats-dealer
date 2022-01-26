Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :cats, only: :index
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'cats/best_deal', to: 'cats#best_deal'
    end
  end
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resource :request, only: %i[create] do
    get :result
  end
end

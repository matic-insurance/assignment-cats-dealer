Rails.application.routes.draw do
  resource :request, only: %i[create] do
    get :result
  end
end

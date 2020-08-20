Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'best_prices#new'

  resource :best_prices, only: %i[show create new]
end

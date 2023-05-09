Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create destroy]
      resources :tokens, only: :create
      resources :products, only: %i[index create]

      match 'product/inactive/:id', to: 'products#inactive', via: [:put], as: :product_inactive
    end
  end
end

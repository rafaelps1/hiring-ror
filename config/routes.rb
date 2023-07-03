Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create destroy]
      resources :products, only: %i[index create]

      match 'tokens', to: 'tokens#generate', via: [:post], as: :generate
      match 'product/inactive/:id', to: 'products#inactive', via: [:put], as: :product_inactive
    end
  end
end

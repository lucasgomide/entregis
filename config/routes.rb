Rails.application.routes.draw do
  namespace :v1 do
    resources :shipping_carriers do
      resources :carriers
    end

    resources :freights, only: %i[create destroy show] do
      resources :items, controller: :freight_items

      member do
        get :search_carriers
      end
    end
  end
end

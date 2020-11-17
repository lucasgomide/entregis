Rails.application.routes.draw do
  namespace :v1 do
    resources :shipping_carriers do
      resources :carriers
    end
  end
end

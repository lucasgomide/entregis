Rails.application.routes.draw do
  namespace :v1 do
    resources :shipping_carriers do
      resources :carriers
    end

    # TODO: Support to detail a freight
    resources :freights, only: %i[create destroy] do
      member do
        get :search_carriers
      end
    end
  end
end

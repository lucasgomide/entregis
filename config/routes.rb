Rails.application.routes.draw do
  namespace :v1 do
    resources :shipping_carriers do
      resources :carriers
    end

    # TODO: Support to destroy and detail a freight
    resources :freights, only: [:create]
  end
end

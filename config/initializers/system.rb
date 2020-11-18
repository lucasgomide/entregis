require 'dry/matcher/result_matcher'

Dry::Rails.container do
  config.features = %i[
    application_contract
    safe_params
    controller_helpers
  ]

  config.root = (Pathname.pwd + 'app')

  custom_paths = %w[
    builders
    operations
    contracts
    filters
    factories
  ]

  auto_register!(*custom_paths)
end

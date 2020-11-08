Dry::Rails.container do
  config.features = %i[
    application_contract
    safe_params
  ]

  config.root = (Pathname.pwd + 'app')

  custom_paths = %w[
    operations
    contracts
  ]

  auto_register!(*custom_paths)
end

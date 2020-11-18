module Carriers
  class CreateOperation
    include BaseCreateOperation
    include Entregis::Deps[
      creation_contract: 'carriers.creation_contract',
      builder: 'carriers.creation_builder',
    ]

    def model
      Carrier
    end

    def call(input)
      contract = (yield validate(input)).to_h
      params = yield builder.from_params(contract).build_attributes
      create(params)
    end
  end
end

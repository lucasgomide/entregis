module Carriers
  class UpdateOperation
    include BaseUpdateOperation
    include Entregis::Deps[
      updating_contract: 'carriers.updating_contract',
      builder: 'carriers.creation_builder',
    ]

    def model
      Carrier
    end

    def call(input)
      contract = (yield validate(input)).to_h
      resource = yield find_resource(contract)
      params = yield builder.from_params(contract).build_attributes

      # Should allow to update a carrier's vehicle when it is
      # not available or in full capacity?
      update(resource, params.except(:id))
    end

    def find_resource(input)
      Try(ActiveRecord::RecordNotFound) do
        model.find_by!(id: input[:id], shipping_carrier_id: input[:shipping_carrier_id])
      end
    end
  end
end

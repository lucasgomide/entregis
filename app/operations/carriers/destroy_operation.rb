module Carriers
  class DestroyOperation
    include BaseDestroyOperation
    include Entregis::Deps[
      destroy_contract: 'carriers.deleting_contract',
    ]

    def model
      Carrier
    end

    def find_resource(input)
      Try(ActiveRecord::RecordNotFound) do
        model.find_by!(id: input[:id], shipping_carrier_id: input[:shipping_carrier_id])
      end
    end
  end
end

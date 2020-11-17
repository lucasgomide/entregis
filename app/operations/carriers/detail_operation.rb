module Carriers
  class DetailOperation
    include BaseDetailOperation

    def call(input)
      Try(ActiveRecord::RecordNotFound) do
        Carrier.find_by!(id: input[:id], shipping_carrier_id: input[:shipping_carrier_id])
      end
    end
  end
end

module V1
  class SearchFreightCarrierSerializer < ActiveModel::Serializer
    def attributes(*_args)
      shipping_carrier = object.shipping_carrier

      {
        company: shipping_carrier.serializable_hash(only: 'name')
      }
    end
  end
end

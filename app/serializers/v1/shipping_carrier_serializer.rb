module V1
  class ShippingCarrierSerializer < ActiveModel::Serializer
    attributes :name, :document

    has_many :carriers, serializer: CarrierSerializer
  end
end

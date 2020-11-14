module V1
  class ShippingCarrierSerializer < ActiveModel::Serializer
    attributes :name, :document
  end
end

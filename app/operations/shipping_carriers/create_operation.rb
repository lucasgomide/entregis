module ShippingCarriers
  class CreateOperation
    include BaseCreateOperation
    include Entregis::Deps[
      creation_contract: 'shipping_carriers.creation_contract',
    ]

    def model
      ShippingCarrier
    end
  end
end

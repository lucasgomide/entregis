module ShippingCarriers
  class UpdateOperation
    include BaseUpdateOperation
    include Entregis::Deps[
      updating_contract: 'shipping_carriers.updating_contract',
    ]

    def model
      ShippingCarrier
    end
  end
end

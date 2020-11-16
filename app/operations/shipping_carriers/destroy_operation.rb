module ShippingCarriers
  class DestroyOperation
    include BaseDestroyOperation

    def model
      ShippingCarrier
    end
  end
end

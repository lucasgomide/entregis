module ShippingCarriers
  class ListOperation
    include BaseFilterOperation
    include Entregis::Deps[
      contract: 'base_list_contract',
    ]

    def model
      ShippingCarrier
    end
  end
end

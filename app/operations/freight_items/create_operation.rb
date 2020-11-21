module FreightItems
  class CreateOperation
    include BaseCreateOperation
    include Entregis::Deps[
      creation_contract: 'freight_items.creation_contract',
    ]

    def model
      FreightItem
    end
  end
end

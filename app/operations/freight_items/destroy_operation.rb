module FreightItems
  class DestroyOperation
    include BaseDestroyOperation
    include Entregis::Deps[
      destroy_contract: 'freight_items.deleting_contract',
    ]

    def model
      FreightItem
    end

    def find_resource(input)
      Try(ActiveRecord::RecordNotFound) do
        model.find_by!(id: input[:id], freight_id: input[:freight_id])
      end
    end
  end
end

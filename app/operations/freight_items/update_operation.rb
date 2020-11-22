module FreightItems
  class UpdateOperation
    include BaseUpdateOperation
    include Entregis::Deps[
      updating_contract: 'freight_items.updating_contract',
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

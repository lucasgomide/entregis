module FreightItems
  class DestroyOperation
    include BaseDestroyOperation
    include Entregis::Deps[
      destroy_contract: 'freight_items.deleting_contract',
      update_freight_total: 'freight_items.update_freight_total_operation',
    ]

    # By creating an freight item with the valid contract input.
    # After creating the freight (parent) is updated with the new volume and weight
    # data from item
    def delete(resource)
      Try(ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid,
          ActiveRecord::Rollback) do
        update_freigth_attributes = ->(item) { update_freight_total.call(item) }

        model.transaction do
          resource.destroy!.tap(&update_freigth_attributes)
        end
      end
    end

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

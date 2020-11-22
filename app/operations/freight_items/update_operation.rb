module FreightItems
  class UpdateOperation
    include BaseUpdateOperation
    include Entregis::Deps[
      updating_contract: 'freight_items.updating_contract',
      update_freight_total: 'freight_items.update_freight_total_operation',
    ]

    # By updating a freight's item with the valid contract input.
    # After updating, the freight (parent) will be updated including the new volume
    # and weight data from item.
    # If any error occurs on item creation or freight updating an Result Monad
    # will returns.
    def update(resource, input)
      Try(ActiveRecord::RecordInvalid, ActiveRecord::Rollback) do
        update_freigth_attributes = ->(item) { update_freight_total.call(item) }
        model.transaction do
          resource.tap do |r|
            r.update!(input)
            update_freigth_attributes.call(r)
          end
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

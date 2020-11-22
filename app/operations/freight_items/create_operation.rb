module FreightItems
  class CreateOperation
    include BaseCreateOperation
    include Entregis::Deps[
      creation_contract: 'freight_items.creation_contract',
      update_freight_total: 'freight_items.update_freight_total_operation',
    ]

    # By creating a freight's item with the valid contract input.
    # After creating, the freight (parent) is updated with the new volume and weight
    # data from item.
    # If any error occurs on item creation or freight updating an Result Monad
    # will returns.
    def create(contract)
      Try(ActiveRecord::RecordInvalid, ActiveRecord::Rollback) do
        update_freigth_attributes = ->(item) { update_freight_total.call(item) }

        model.transaction do
          model.create!(contract).tap(&update_freigth_attributes)
        end
      end
    end

    def call(input)
      contract = (yield validate(input)).to_h
      create(contract)
    end

    def model
      FreightItem
    end
  end
end

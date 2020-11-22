module FreightItems
  class UpdateFreightTotalOperation
    include BaseCreateOperation

    # Re-calculating the volume and weight total of freight. This method is called
    # when some freight's item is updated, created or deleted.
    # For each action on freight's item, the parent freight is updated.
    def call(item)
      item.freight.tap do |freight|
        items = freight.items
        freight.update!(
          cubic_meters_total: items.sum(&:cubic_meters),
          weight_total: items.sum(&:weight)
        )
      end
    end
  end
end

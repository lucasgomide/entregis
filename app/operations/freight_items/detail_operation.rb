module FreightItems
  class DetailOperation
    include BaseDetailOperation

    def call(input)
      Try(ActiveRecord::RecordNotFound) do
        FreightItem.find_by!(id: input[:id], freight_id: input[:freight_id])
      end
    end
  end
end

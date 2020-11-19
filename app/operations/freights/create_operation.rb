module Freights
  class CreateOperation
    include BaseCreateOperation

    include Entregis::Deps[
      creation_contract: 'freights.creation_contract',
      builder: 'freights.creation_builder',
    ]

    def call(input)
      contract = (yield validate(input)).to_h
      params = yield builder.from_params(contract).build_attributes

      Try(ActiveRecord::RecordInvalid) do
        create(params)
      end
    end

    def create(input)
      Freight.transaction do
        items = input[:items]
        Freight.create!(
          origin: input[:origin], destination: input[:destination],
          cubic_meters_total: items.sum { |item| item[:cubic_meters] },
          weight_total: items.sum { |item| item[:weight] }
        ).tap do |freight|
          freight.items.create!(items)
        end
      end
    end
  end
end

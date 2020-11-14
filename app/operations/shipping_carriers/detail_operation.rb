module ShippingCarriers
  class DetailOperation
    include Dry::Monads[:try]

    def call(input)
      Try[ActiveRecord::RecordNotFound] { ShippingCarrier.find(input[:id]) }
    end
  end
end

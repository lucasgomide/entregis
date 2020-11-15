module ShippingCarriers
  class CreateOperation
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)
    include Entregis::Deps[
      creation_contract: 'shipping_carriers.creation_contract',
    ]

    def call(input)
      contract = (yield validate(input)).to_h
      create(contract)
    end

    private

    def validate(input)
      creation_contract.call(input).to_monad
    end

    def create(input)
      Try[ActiveRecord::RecordInvalid] do
        ShippingCarrier.create!(input)
      end
    end
  end
end

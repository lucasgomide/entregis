module ShippingCarriers
  class UpdateOperation
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)
    include Entregis::Deps[
      updating_contract: 'shipping_carriers.updating_contract',
    ]

    def call(input)
      contract = (yield validate(input)).to_h
      resource = yield find_resource(contract)
      update(resource, contract.except(:id))
    end

    private

    def validate(input)
      updating_contract.call(input).to_monad
    end

    def find_resource(input)
      Try[ActiveRecord::RecordNotFound] { ShippingCarrier.find(input[:id]) }
    end

    def update(resource, input)
      Try[ActiveRecord::RecordInvalid] do
        resource.tap do |r|
          r.update!(input)
        end
      end
    end
  end
end

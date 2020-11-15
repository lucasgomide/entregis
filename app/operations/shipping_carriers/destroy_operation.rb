module ShippingCarriers
  class DestroyOperation
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)
    include Entregis::Deps[
      destroy_contract: 'primary_key_contract',
    ]

    def call(input)
      contract = (yield validate(input)).to_h
      resource = yield find_resource(contract)
      delete(resource)
    end

    private

    def validate(input)
      destroy_contract.call(input).to_monad
    end

    def find_resource(input)
      Try[ActiveRecord::RecordNotFound] { ShippingCarrier.find(input[:id]) }
    end

    def delete(resource)
      Try[ActiveRecord::RecordInvalid] do
        resource.destroy!
      end
    end
  end
end

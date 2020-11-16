# frozen_string_literal: true

require 'active_support/concern'

module BaseDestroyOperation
  extend ActiveSupport::Concern

  included do
    include Dry::Monads::Try::Mixin
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
      Try(ActiveRecord::RecordNotFound) { model.find(input[:id]) }
    end

    def delete(resource)
      Try(ActiveRecord::RecordNotFound) do
        resource.destroy!
      end
    end
  end
end

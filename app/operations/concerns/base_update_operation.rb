# frozen_string_literal: true

require 'active_support/concern'

module BaseUpdateOperation
  extend ActiveSupport::Concern

  included do
    include Dry::Monads::Try::Mixin
    include Dry::Monads::Do.for(:call)

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
      Try(ActiveRecord::RecordNotFound) { model.find(input[:id]) }
    end

    def update(resource, input)
      Try(ActiveRecord::RecordInvalid) do
        resource.tap { |r| r.update!(input) }
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/concern'

module BaseCreateOperation
  extend ActiveSupport::Concern

  included do
    include Dry::Monads::Try::Mixin
    include Dry::Monads::Do.for(:call)

    def call(input)
      contract = (yield validate(input)).to_h
      create(contract)
    end

    private

    def validate(input)
      creation_contract.call(input).to_monad
    end

    def create(input)
      Try(ActiveRecord::RecordInvalid) do
        model.create!(input)
      end
    end
  end
end

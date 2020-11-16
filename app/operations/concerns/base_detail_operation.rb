# frozen_string_literal: true

require 'active_support/concern'

module BaseDetailOperation
  extend ActiveSupport::Concern

  included do
    include Dry::Monads::Try::Mixin

    def call(input)
      Try(ActiveRecord::RecordNotFound) { model.find(input[:id]) }
    end
  end
end

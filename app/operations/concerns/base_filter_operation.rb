# frozen_string_literal: true

require 'active_support/concern'

module BaseFilterOperation
  extend ActiveSupport::Concern

  included do
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)
    include Entregis::Deps[
      paginate: 'paginate_filter'
    ]

    def call(input)
      parameters = (yield contract.call(input).to_monad).to_h
      result = yield paginate.call(model, parameters.slice(:page))
      Success(result.where(parameters.except(:page)))
    end
  end
end

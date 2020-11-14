# frozen_string_literal: true

class PaginateFilter
  include Dry::Monads[:result]

  DEFAULT_PAGE = 1
  DEFAULT_PAGE_SIZE = 30

  def call(model, attrs = {})
    Success(
      model.page(attrs[:page] || DEFAULT_PAGE)
          .per(attrs[:per_page] || DEFAULT_PAGE_SIZE)
    )
  end
end

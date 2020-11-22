# frozen_string_literal: true

class PaginateFilter
  include Dry::Monads[:result]

  DEFAULT_PAGE = 1
  DEFAULT_PAGE_SIZE = 30

  def call(model, attrs = {})
    size, number = attrs.fetch(:page, {}).slice(:size, :number).values
    Success(
      model.page(number || DEFAULT_PAGE)
          .per(size || DEFAULT_PAGE_SIZE)
    )
  end
end

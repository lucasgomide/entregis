module Freights
  class SearchCarriersOperation
    include Dry::Monads::Try::Mixin
    include Dry::Monads::Do.for(:call)

    include Entregis::Deps[
      filter_factory: 'freights.filter_factory',
      search_contract: 'freights.search_carrier_contract',
      paginate: 'paginate_filter',
    ]

    # This method receive an input with the freight_id, sort and pagination_paramenters.
    # The input is validated and the filter is applied using the
    # requested sort parameter.
    # After filtering the paginator over the filter results is applied.
    # The outcome will be a Result Monad, by returning Success if the proccess has
    # been completed, or a Failure once an error has occurred.

    # For now, we're supporting the following filters: Closest and Cheapest.
    # TODO: Would be great to support a kind of the most relevant (scoring).
    # It could be calculated by the score for each carrier.

    # TODO: It would be great to return the estimeted tax for each carriear also well.

    def call(input)
      contract = (yield validate(input)).to_h
      resource = yield find_resource(contract)
      filter = filter_factory.from_sort_type(contract[:sort])

      result = yield filter.call(resource)
      paginate.call(result, contract.slice(:page))
    end

    private

    def validate(input)
      search_contract.call(input).to_monad
    end

    def find_resource(input)
      Try(ActiveRecord::RecordNotFound) do
        Freight.find(input[:id])
      end
    end
  end
end

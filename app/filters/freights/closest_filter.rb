module Freights
  class ClosestFilter
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)
    include Entregis::Deps[
      base_filter: 'freights.search_base_filter',
    ]

    # This method runs the base_filter (which some default rules are applied).
    # After call the base_filter the result is ordered by distance of the
    # carries' current_location with the freight's origin location
    def call(freight)
      query = Arel.sql(
        "ST_Distance(ST_GeomFromText('#{freight.origin}'), carriers.current_location)"
      )
      result = yield base_filter.call(freight)
      Success(result.order(query))
    end
  end
end

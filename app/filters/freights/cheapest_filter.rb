module Freights
  class CheapestFilter
    include Dry::Monads::Do.for(:call)
    include Dry::Monads[:result]
    include Entregis::Deps[
      base_filter: 'freights.search_base_filter',
    ]
    # This method runs the base_filter (to which some default rules are applied).
    # After calling the base_filter the result is sorted by
    # price per KM * distance in meters (linear). That means the cheapest carrier per KM.

    # That might be one of such important business rules. How to calculate the
    # tax to ship the freight. For now, it's ok to use the price per KM,
    # but there are others pricing models, such as: calculate the freight's KG,
    # share all tax for each customer (assess), etc.
    # It means that obviously, the current model is not the best. That's a big deal.

    def call(freight)
      query = Arel.sql(
        'ST_DistanceSphere(ST_Centroid(carriers.current_location::geometry),' \
            "ST_GeomFromText('#{freight.origin}',4326)) * km_price_cents"
      )
      result = yield base_filter.call(freight)
      Success(result.order(query))
    end
  end
end

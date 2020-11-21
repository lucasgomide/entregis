module Freights
  module Filters
    class DistanceOperation
      include Entregis::Deps[
        base_filter: 'freights.filters.default_operation',
      ]

      # This method runs the base_filter (which some default rules are applied).
      # After call the base_filter the result is ordered by distance of the
      # carries' current_location with the freight's origin location
      def call(freight)
        base_filter.call(freight).order(
          Arel.sql(
            "ST_Distance(ST_GeomFromText('#{freight.origin}'), carriers.current_location)"
          )
        )
      end
    end
  end
end

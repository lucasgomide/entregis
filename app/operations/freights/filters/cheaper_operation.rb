module Freights
  module Filters
    class CheaperOperation
      include Entregis::Deps[
        base_filter: 'freights.filters.default_operation',
      ]

      # This method runs the base_filter (to which some default rules are applied).
      # After calling the base_filter the result is sorted by price per KM.
      # That might be one of such important business rules. How to calculate the
      # tax to ship the freight. For now, it's ok to use the price per KM,
      # but there are others pricing models, such as: calculate the freight's KG,
      # share all tax for each customer (assess), etc.
      # It means that obviously, the current model is not the best. That's a big deal.
      def call(freight)
        base_filter.call(freight).order(:km_price_cents)
      end
    end
  end
end

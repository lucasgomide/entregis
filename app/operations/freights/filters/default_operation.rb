module Freights
  module Filters
    class DefaultOperation
      # This method apply a sequence of default filters to find
      # the best carrier to pick up the order. The follow rules are applied:
      # - only available (not busy);
      # - free storage greater than freight's volume;
      # - available payload greater than freight's total weight;
      # - the freight's origin and destination is coveraged;
      # There's an relevant point, the coverage area is not required, thus some
      # carrier may not have the coverage area set. What should we do?
      def call(freight)
        origin, destination = freight.slice(:origin, :destination).values
        Carrier.available.where(available_payload_cubic_meters(freight)).where(
          'ST_Contains(carriers.coverage_area, ST_GeomFromText(:origin))',
          origin: origin.to_s
        ).where(
          'ST_Contains(carriers.coverage_area, ST_GeomFromText(:destination))',
          destination: destination.to_s
        )
      end

      private

      def available_payload_cubic_meters(freight)
        Carrier.arel_table[:available_payload].gteq(freight.weight_total).and(
          Carrier.arel_table[:available_cubic_meters].gteq(freight.cubic_meters_total)
        )
      end
    end
  end
end

module Carriers
  class CreationContract < ApplicationContract
    params do
      required(:shipping_carrier_id).value(:integer)
      required(:current_location).filled(Types::Point)
      required(:vehicle_id).value(:integer)
      required(:status).value(included_in?: Carrier.statuses.keys)

      required(:km_price_cents).value(:integer)
      optional(:km_price_currency).value(:string)

      required(:weight_price_cents).value(:integer)
      optional(:weight_price_currency).value(:string)

      optional(:coverage_area).value(Types::MultiPolygon)
    end
  end
end

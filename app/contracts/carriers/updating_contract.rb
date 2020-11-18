module Carriers
  class UpdatingContract < ApplicationContract
    # This contract has the same attributes of CreationContract.
    # Althought all fields are optionals

    params(DeletingContract.schema) do
      optional(:current_location).filled(Types::Point)
      optional(:vehicle_id).value(:integer)
      optional(:status).value(included_in?: Carrier.statuses.keys)

      optional(:km_price_cents).value(:integer)
      optional(:km_price_currency).value(:string)

      optional(:weight_price_cents).value(:integer)
      optional(:weight_price_currency).value(:string)

      optional(:coverage_area).value(Types::MultiPolygon)
    end
  end
end

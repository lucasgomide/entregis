module Freights
  class SearchCarrierContract < ApplicationContract
    params(BaseListContract.schema) do
      required(:id).value(:integer)
      required(:sort).value(:string, included_in?: %w[closest cheapest])
      optional(:per_page).value(:integer, gt?: 0, lteq?: 10)
    end
  end
end

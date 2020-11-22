module Freights
  class SearchCarrierContract < ApplicationContract
    params do
      required(:id).value(:integer)
      required(:sort).value(:string, included_in?: %w[closest cheapest])
      required(:page).hash do
        required(:size).value(:integer, gt?: 0, lteq?: 10)
        optional(:number).value(:integer)
      end
    end
  end
end

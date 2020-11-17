module Carriers
  class ListContract < ApplicationContract
    params(BaseListContract.schema) do
      required(:shipping_carrier_id).value(:integer)
    end
  end
end

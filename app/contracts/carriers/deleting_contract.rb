module Carriers
  class DeletingContract < ApplicationContract
    params(PrimaryKeyContract.schema) do
      required(:shipping_carrier_id).value(:integer)
    end
  end
end

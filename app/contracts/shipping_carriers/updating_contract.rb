module ShippingCarriers
  class UpdatingContract < ApplicationContract
    params(
      ShippingCarriers::CreationContract.schema,
      PrimaryKeyContract.schema
    )
  end
end

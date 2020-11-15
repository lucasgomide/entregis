module ShippingCarriers
  class UpdatingContract < ApplicationContract
    params(
      ShippingCarriers::CreationContract.schema,
      BaseUpdatingContract.schema
    )
  end
end

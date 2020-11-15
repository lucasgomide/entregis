module ShippingCarriers
  class CreationContract < ApplicationContract
    params do
      optional(:name).value(:string)
      optional(:document).value(:string)
    end
  end
end

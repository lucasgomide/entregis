module ShippingCarriers
  class UpdatingContract < BaseUpdatingContract
    params do
      optional(:name).value(:string)
      optional(:document).value(:string)
    end
  end
end

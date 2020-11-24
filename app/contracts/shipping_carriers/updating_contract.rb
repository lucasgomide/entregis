module ShippingCarriers
  class UpdatingContract < DocumentContract
    params(PrimaryKeyContract.schema) do
      optional(:name).value(:string)
      optional(:document).value(:string, min_size?: 11, max_size?: 18)
    end

    rule(:document).validate(:valid_document?)
  end
end

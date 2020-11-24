module ShippingCarriers
  class CreationContract < DocumentContract
    params do
      required(:name).value(:string)
      required(:document).value(:string, min_size?: 11, max_size?: 18)
    end

    rule(:document).validate(:valid_document?)
  end
end

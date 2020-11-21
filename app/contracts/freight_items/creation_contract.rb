module FreightItems
  class CreationContract < ApplicationContract
    params do
      required(:cubic_meters).value(:float, gt?: 0)
      required(:weight).value(:float, gt?: 0)
      required(:freight_id).value(:integer)
    end
  end
end

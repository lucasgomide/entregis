module FreightItems
  class DeletingContract < ApplicationContract
    params(PrimaryKeyContract.schema) do
      required(:freight_id).value(:integer)
    end
  end
end

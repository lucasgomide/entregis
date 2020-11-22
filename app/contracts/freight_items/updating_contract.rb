module FreightItems
  class UpdatingContract < ApplicationContract
    # This contract has the same attributes of CreationContract.
    # Althought all fields are optionals, except the IDs

    params(DeletingContract.schema) do
      optional(:cubic_meters).value(:float, gt?: 0)
      optional(:weight).value(:float, gt?: 0)
    end
  end
end

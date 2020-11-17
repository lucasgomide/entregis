module Carriers
  class ListOperation
    include BaseFilterOperation
    include Entregis::Deps[
      contract: 'carriers.list_contract',
    ]

    def model
      Carrier
    end
  end
end

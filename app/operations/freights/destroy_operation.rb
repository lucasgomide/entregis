module Freights
  class DestroyOperation
    include BaseDestroyOperation

    def model
      Freight
    end
  end
end

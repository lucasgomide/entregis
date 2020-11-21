module Freights
  class FilterFactory
    def from_sort_type(type)
      Entregis::Container.resolve("freights.#{type}_filter")
    end
  end
end

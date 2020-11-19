module Freights
  class CreationContract < ApplicationContract
    params do
      required(:origin).filled(Types::Point)
      required(:destination).filled(Types::Point)

      required(:items).value(:array, min_size?: 1) do
        each(:hash) do
          required(:cubic_meters).filled(Types::Float)
          required(:weight).filled(Types::Float)
        end
      end
    end
  end
end

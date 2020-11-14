module V1
  class ShippingCarriersController < ApplicationController
    include DefineOperation
    include Renderer
    include Dry::Matcher.for(:operation, with: Dry::Matcher::ResultMatcher)

    def index
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end
  end
end

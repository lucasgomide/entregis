module V1
  class ShippingCarriersController < ApplicationController
    include BaseController

    def index
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end

    def show
      success = ->(body) { render_success(body, include: ['carriers']) }

      operation do |m|
        m.success(&success)
        m.failure(&method(:render_invalid))
      end
    end

    def update
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end

    def create
      operation do |m|
        m.success(&method(:render_created))
        m.failure(&method(:render_invalid))
      end
    end

    def destroy
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end
  end
end

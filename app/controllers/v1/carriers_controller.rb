module V1
  class CarriersController < ApplicationController
    include BaseController

    def index
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end

    def show
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
  end
end

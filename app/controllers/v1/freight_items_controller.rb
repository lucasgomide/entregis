module V1
  class FreightItemsController < ApplicationController
    include BaseController

    def show
      operation do |m|
        m.success(&method(:render_success))
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

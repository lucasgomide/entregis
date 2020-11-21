module V1
  class FreightsController < ApplicationController
    include BaseController
    def create
      operation do |m|
        success = ->(body) { render_created(body, include: ['items']) }

        m.success(&success)
        m.failure(&method(:render_invalid))
      end
    end

    def destroy
      operation do |m|
        m.success(&method(:render_success))
        m.failure(&method(:render_invalid))
      end
    end

    def search_carriers
      success = lambda do |body|
        render_success(body, each_serializer: SearchFreightCarrierSerializer)
      end

      operation do |m|
        m.success(&success)
        m.failure(&method(:render_invalid))
      end
    end
  end
end

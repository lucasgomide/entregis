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
  end
end

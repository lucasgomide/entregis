# frozen_string_literal: true

require 'active_support/concern'

module DefineOperation
  extend ActiveSupport::Concern

  def operation
    @operation ||= resolve('operation_factory').from_controller(self)
                                               .call(permitted_params)
  end

  def permitted_params
    params.except(:format, :controller, :action).to_unsafe_h
  end
end

# frozen_string_literal: true

require 'active_support/concern'

module Renderer
  extend ActiveSupport::Concern

  def render_invalid(object)
    render_error(object)
  end

  def render_success(result)
    render json: result
  end

  private

  def render_error(object)
    error = resolve('error_factory').from_object(object)

    render json: error,
           status: error.status,
           adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end

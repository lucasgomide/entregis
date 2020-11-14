# frozen_string_literal: true

require 'active_support/concern'

module Renderer
  extend ActiveSupport::Concern

  def render_invalid(object)
    render_error(object, :bad_request)
  end

  def render_success(result)
    render json: result
  end

  private

  def render_error(error, status = :bad_request)
    render json: resolve('error_factory').from_object(error),
           status: status,
           adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end

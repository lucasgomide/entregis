# frozen_string_literal: true

module ValidationContract
  def validation_contract(success: true, input: {})
    params = double(:params, message_set: [], to_h: input)

    Dry::Validation::Result.new(params) do |r|
      r.add_error(Dry::Validation::Message.new('not valid', path: :key)) unless success
    end
  end
end

RSpec.configure do |config|
  config.include ValidationContract
end

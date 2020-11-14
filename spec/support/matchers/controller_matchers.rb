# frozen_string_literal: true

module ControllerMatchers
  extend RSpec::Matchers::DSL

  RSpec::Matchers.define :serialize_object do |expected|
    match do |response|
      @result = serialize(expected).to_json

      @result == response.body
    end

    description do
      "serialize object #{@result} with #{@serializer_klass}"
    end

    chain :with_array_of do |serializer_klass, options = {}|
      @collection = true
      add_serializer(serializer_klass, options)
    end

    chain :with do |serializer_klass, options = {}|
      @collection = false
      add_serializer(serializer_klass, options)
    end

    failure_message do |actual|
      "expected that #{actual.body} would be eq #{@result}"
    end

    def add_serializer(serializer_klass, _options = {})
      @options = {}
      @serializer_klass = serializer_klass
    end

    def serialize(expected)
      serializer_key = @collection ? :each_serializer : :serializer
      @options[serializer_key] = @serializer_klass

      ActiveModelSerializers::SerializableResource.new(expected, @options)
                                                  .serializable_hash
    end
  end
end

RSpec.configure do |config|
  config.include ControllerMatchers, type: :controller
end

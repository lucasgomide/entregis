module Concerns
  module Buildable
    extend ActiveSupport::Concern

    included do
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:build_attributes)
      attr_reader :attributes

      class_attribute :builder_class
    end

    def initialize(attributes = ActiveSupport::HashWithIndifferentAccess.new)
      @attributes = attributes
    end

    def from_params(params = {})
      @attributes.merge!(params)
      self
    end

    def build_attributes
      Success(@attributes.dup.deep_symbolize_keys.tap { clear })
    end

    protected

    def add(attribute, value)
      @attributes[attribute] = value
      self
    end

    private

    def clear
      @attributes = @attributes.class.new
    end
  end
end

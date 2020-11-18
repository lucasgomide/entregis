module Types
  include Dry.Types()

  MultiPolygon ||= Types::Params::Array.of(
    Types::Params::Array.constrained(size: 1).of(
      Types::Params::Array.constrained(min_size: 2).of(
        Types::Params::Array.constrained(size: 2).of(Types::Float)
      )
    )
  ).freeze

  Point ||= Types::Params::Array.constrained(size: 2).of(Types::Float).freeze
end

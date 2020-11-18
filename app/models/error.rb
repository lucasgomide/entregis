class Error < Dry::Struct
  include Types

  attribute :status, Types::Strict::Symbol.optional
  attribute :errors do
    attribute :messages, 'hash'
  end
end

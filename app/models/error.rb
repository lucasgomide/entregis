class Error < Dry::Struct
  attribute :errors do
    attribute :messages, 'hash'
  end
end

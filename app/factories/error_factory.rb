class ErrorFactory
  ERRORS_RESOLVERS = {
    'Dry::Validation::Result' => ->(it) { it.errors.to_h },
    'ActiveRecord::RecordInvalid' => ->(it) { it.record.errors.messages }
  }.freeze

  def from_object(object)
    messages = ERRORS_RESOLVERS[object.class.name]&.call(object) || [object.as_json]

    Error.new(errors: { messages: messages })
  end
end

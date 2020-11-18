class ErrorFactory
  ERRORS_RESOLVERS = {
    'Dry::Validation::Result' => ->(it) { it.errors.to_h },
    'ActiveRecord::RecordInvalid' => ->(it) { it.record.errors.messages },
    'ActiveRecord::RecordNotFound' => ->(it) { { id: [it.message] } },
    'RGeo::Error::InvalidGeometry' => ->(it) { { invalid_geometry: [it.message] } }
  }.freeze

  STATUS_ERROR = {
    'ActiveRecord::RecordNotFound' => :not_found
  }.freeze

  def from_object(object)
    messages = ERRORS_RESOLVERS[object.class.name]&.call(object) || [object.as_json]
    status = STATUS_ERROR.fetch(object.class.name, :bad_request)

    Error.new(errors: { messages: messages }, status: status)
  end
end

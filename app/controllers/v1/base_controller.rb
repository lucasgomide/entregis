module V1
  module BaseController
    include DefineOperation
    include Renderer
    include Dry::Matcher.for(:operation, with: Dry::Matcher::ResultMatcher)
  end
end

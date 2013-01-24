module OAS
  class Error < StandardError; end
  class Error::Forbidden < Error; end
  class Error::GatewayTimeout < Error; end
  class Error::InternalServerError < Error; end
  class Error::ServiceUnavailable < Error; end
end
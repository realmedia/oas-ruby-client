module OAS
  class Error < StandardError; end
  class Error::HTTP < Error; end
  class Error::HTTP::Forbidden < Error::HTTP; end
  class Error::HTTP::BadGateway < Error::HTTP; end
  class Error::HTTP::GatewayTimeout < Error::HTTP; end
  class Error::HTTP::InternalServerError < Error::HTTP; end
  class Error::HTTP::ServiceUnavailable < Error::HTTP; end
end
module OAS
  class Error < StandardError; end

  class Error::HTTP < Error
    attr_reader :code, :headers, :body

    def initialize(code, headers, body)
      @code    = code
      @headers = headers
      @body    = body
    end

    BadRequest   = Class.new(self)
    Unauthorized = Class.new(self)
    Forbidden    = Class.new(self)
    NotFound     = Class.new(self)
    UnprocessableEntity = Class.new(self)
    TooManyRequests     = Class.new(self)
    BadGateway          = Class.new(self)
    GatewayTimeout      = Class.new(self)
    InternalServerError = Class.new(self)
    ServiceUnavailable  = Class.new(self)
  end
end
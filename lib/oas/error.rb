module Oas
  # Custom error class for rescuing from all Oas errors
  class Error < StandardError
    attr_reader :error_code

    def initialize(message, error_code)
      @error_code = error_code
      super message
    end
  end
  
  # Raised when Oas returns the error code 550
  class InvalidSite < Error; end
  
  # Raised when Oas returns the error code 551
  class InvalidUrl < Error; end
end
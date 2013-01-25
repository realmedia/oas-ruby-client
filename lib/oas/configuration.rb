module OAS
  module Configuration
    # An array of valid keys in the options hash when configuring a {OAS::Client}
    VALID_OPTIONS_KEYS = [
      :endpoint,      
      :account,
      :username,
      :password,
      :logger].freeze
    
    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = "https://oas.realmediadigital.com/oasapi/OaxApi".freeze
    
    # The account that will be used to connect if none is set
    DEFAULT_ACCOUNT = "OasDefault"
    
    # By default, don't set a username
    DEFAULT_USERNAME = nil
    
    # By default, don't set a password
    DEFAULT_PASSWORD = nil
    
    attr_accessor *VALID_OPTIONS_KEYS
    
    def self.extended(base)
      base.reset!
    end
    
    def configure
      yield self if block_given?
    end
    
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k) }
      options
    end
    
    def reset!
      self.endpoint   = DEFAULT_ENDPOINT
      self.account    = DEFAULT_ACCOUNT
      self.username   = DEFAULT_USERNAME
      self.password   = DEFAULT_PASSWORD
      self.logger     = nil
    end
  end
end

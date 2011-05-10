Dir[File.join(File.dirname(__FILE__),'oas/core_ext/**/*.rb')].each {|f| require f}

require 'oas/error'
require 'oas/configuration'
require 'oas/api'
require 'oas/client'

module Oas
  extend Configuration
  
  # Alias for Oas::Client.new
  #
  # @return [Oas::Client]
  def self.client(options={})
    Oas::Client.new(options)
  end
  
  # Delegate to Oas::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end
end

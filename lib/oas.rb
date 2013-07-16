require 'oas/error'
require 'oas/configuration'
require 'oas/client'
require 'oas/request'
require 'oas/version'

module OAS
  extend Configuration

  def self.client(options={})
    @client = OAS::Client.new(options) unless defined?(@client)
    @client
  end
  
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to_missing?(method, include_private = false)
    client.respond_to?(method, include_private)
  end
end

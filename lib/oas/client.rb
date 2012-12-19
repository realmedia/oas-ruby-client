require 'httpclient'
require 'savon'

module OAS
  class Client   
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_accessor :driver

    def initialize(options={})
      options = OAS.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def driver
      @driver ||= Savon::Client.new do |client|
        client.endpoint endpoint.to_s
        client.namespace "http://api.oas.tfsm.com/"
        client.namespace_identifier :n1
        client.convert_request_keys_to :camelcase
        client.log false
      end
    end

    def request(msg)
      doc = msg.respond_to?(:to_xml) ? msg.to_xml : msg
      res = driver.call :oas_xml_request, message: Hash["String_1", account.to_s, "String_2", username.to_s, "String_3", password.to_s, "String_4", doc.to_s]
      res.body[:oas_xml_request_response][:result]
    rescue Savon::SOAPFault => e
      raise e.to_hash[:fault][:faultstring]
    rescue Savon::HTTPError => e
      raise "Something went wrong. HTTP #{e.http.code}"
    rescue Savon::InvalidResponseError
      raise "Invalid server response"
    end
  end
end
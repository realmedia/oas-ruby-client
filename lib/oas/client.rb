require 'httpclient'
require 'savon'
require 'oas/response'

module OAS
  class Client   
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_writer :driver

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
      OAS::Response.new(res.body[:oas_xml_request_response][:result])
    rescue Savon::HTTPError => e
      raise_http_error!(e)
    rescue Savon::InvalidResponseError => e
      raise OAS::Error.new(e.message)
    end

  private
    def raise_http_error!(e)
      case e.http.code
      when 403
        raise OAS::Error::Forbidden.new
      when 500
        raise OAS::Error::InternalServerError.new
      when 503
        raise OAS::Error::ServiceUnavailable.new
      when 504
        raise OAS::Error::GatewayTimeout.new
      else
        raise OAS::Error.new(e.to_s)
      end
    end

  end
end
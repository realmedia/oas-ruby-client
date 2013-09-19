require 'oas/adxml'
require 'savon'

module OAS
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(opts={})
      options = OAS.options.merge(opts)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end

      @savon = Savon::Client.new do |client|
        client.endpoint endpoint.to_s
        client.namespace "http://api.oas.tfsm.com/"
        client.namespace_identifier :n1
        client.convert_request_keys_to :camelcase
        client.open_timeout timeout.to_i
        client.read_timeout timeout.to_i
        client.ssl_verify_mode :none
        client.logger logger
        client.log !!logger
      end
    end

    def execute(request)
      response = @savon.call :oas_xml_request, message: Hash["String_1", account.to_s, "String_2", username.to_s, "String_3", password.to_s, "String_4", request.to_xml.to_s]
      OAS::AdXML.parse response.body[:oas_xml_request_response][:result]
    rescue Savon::HTTPError => e
      _raise_http_error!(e)
    rescue Savon::InvalidResponseError => e
      raise OAS::Error.new(e.message)
    end

    private

    def _raise_http_error!(e)
      case e.http.code
      when 403
        raise OAS::Error::HTTP::Forbidden.new
      when 500
        raise OAS::Error::HTTP::InternalServerError.new
      when 502
        raise OAS::Error::HTTP::BadGateway.new
      when 503
        raise OAS::Error::HTTP::ServiceUnavailable.new
      when 504
        raise OAS::Error::HTTP::GatewayTimeout.new
      else
        raise OAS::Error::HTTP.new(e.to_s)
      end
    end

  end
end
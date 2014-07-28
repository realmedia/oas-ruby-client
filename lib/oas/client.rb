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
      doc = OAS::AdXML.parse(response.body[:oas_xml_request_response][:result])
      doc.http_headers = response.http.headers
      doc
    rescue Savon::HTTPError => e
      _raise_http_error!(e)
    rescue Savon::InvalidResponseError => e
      raise OAS::Error.new(e.message)
    end

    private

    def _raise_http_error!(e)
      case e.http.code
      when 403
        klass = OAS::Error::HTTP::Forbidden
      when 500
        klass = OAS::Error::HTTP::InternalServerError
      when 502
        klass = OAS::Error::HTTP::BadGateway
      when 503
        klass = OAS::Error::HTTP::ServiceUnavailable
      when 504
        klass = OAS::Error::HTTP::GatewayTimeout
      else
        klass = OAS::Error::HTTP
      end
      raise klass.new(e.http.code, e.http.headers, e.http.body)
    end

  end
end
require 'nokogiri'
require 'httpclient'
require 'soap/wsdlDriver'

module Oas
  class Api
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
      
    def initialize(options={})
      options = Oas.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def request(request_type, &block)
      xml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.AdXML {
          xml.Request(:type => request_type) {
            yield(xml) if block_given?
          }
        }
      end
      response = driver.OasXmlRequest(account,username,password,xml.to_xml)
      response = Hash.from_xml(response.first)[:AdXML][:Response]
      verify_errors(request_type, response)
      response
    end
  
    private
    def verify_errors(request_type, response)
      return if (e = response[:Exception]).nil? && (e = response[request_type.to_sym][:Exception]).nil?
      error_code = e[:errorCode]
      error_msg  = e[:content]
      case error_code
      when 550
         raise Oas::InvalidSite.new(error_msg, error_code)
      when 551
         raise Oas::InvalidPage.new(error_msg, error_code)
      else
         raise Oas::Error.new(error_msg, error_code)
      end
    end
    
    def driver
      @driver ||= SOAP::WSDLDriverFactory.new(endpoint).create_rpc_driver do |d|
        d.options["protocol.http.connect_timeout"] = 10.seconds
        d.options["protocol.http.send_timeout"]    = 10.seconds
        d.options["protocol.http.receive_timeout"] = 2.minutes
      end
    end
  end
end
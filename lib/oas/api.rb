require 'nokogiri'
require 'httpclient'
require 'savon'

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
      response = webservice.request :n1, :oas_xml_request, :"xmlns:n1" => "http://api.oas.tfsm.com/" do
        soap.body = {
          "String_1" => account.to_s,
          "String_2" => username.to_s,
          "String_3" => password.to_s,
          "String_4" => xml.to_xml
        }
      end
      response = Hash.from_xml(response.to_hash[:oas_xml_request_response][:result])[:AdXML][:Response]
      verify_errors(response)
      response
    end
  
    private
    def verify_errors(response)
      return if (e = response[:Exception]).nil? && (e = response[response.keys.first][:Exception]).nil?
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
    
    def webservice
      @webservice ||= Savon::Client.new(endpoint)
    end
  end
end

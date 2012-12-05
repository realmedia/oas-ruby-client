require 'nokogiri'
require 'httpclient'
require 'nori'
require 'savon'

module OAS
  class Client   
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_accessor :soap_client

    def initialize(options={})
      options = OAS.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def soap_client
      @soap_client ||= Savon::Client.new(endpoint)
    end

    def request(request_type, &block)
      xml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.AdXML {
          xml.Request(:type => request_type) {
            yield(xml) if block_given?
          }
        }
      end
      xml.doc
      body = Hash["String_1", account.to_s, "String_2", username.to_s, "String_3", password.to_s, "String_4", xml.to_xml]
      response = soap_client.request :n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]
      Nori.parse(response.to_hash[:oas_xml_request_response][:result])
    end
  end
end

HTTPI.log = false
Nori.parser = :nokogiri
Nori.configure { |c| c.convert_tags_to { |tag| tag.to_sym } }
Savon.configure { |c| c.log = false }
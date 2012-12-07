require 'nokogiri'
require 'httpclient'
require 'nori'
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
      @driver ||= Savon::Client.new(endpoint)
    end

    def request(msg = nil, &block)
      if block_given?
        msg = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          block.call(xml) if block_given?
        end
      else
        raise ArgumentError.new("msg argument must respond to to_xml") unless msg.respond_to?(:to_xml)
      end
      body = Hash["String_1", account.to_s, "String_2", username.to_s, "String_3", password.to_s, "String_4", msg.to_xml]
      res  = driver.request :n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]
      Nokogiri::XML::Document.parse(res.body[:oas_xml_request_response][:result])
    end
  end
end

HTTPI.log = false
Nori.parser = :nokogiri
#Nori.configure { |c| c.convert_tags_to { |tag| tag.to_sym } }
Savon.configure { |c| c.log = false }
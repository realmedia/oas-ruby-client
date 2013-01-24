require 'nokogiri'
require 'nori'

module OAS
  class Response
    attr_writer :parser

    def initialize(doc)
      @doc = Nokogiri.XML(doc)
      validate!
    end

    def parser
      @parser ||= Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.to_sym })
    end

    def to_s
      @doc.to_xml
    end

    def to_hash
      @hash ||= parser.parse(@doc.to_xml)
    end
  
  private
    def validate!
      errors = @doc.xpath('//AdXML/Response//Exception')
      return if errors.empty?
      raise OAS::Error.new(errors.first.text)
    end
  end
end
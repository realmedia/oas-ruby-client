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
      error = errors.first

      case error['errorCode'].to_i
      when 512,514
        raise OAS::Error::DuplicateId.new(error.text)
      when 531..575
        raise OAS::Error::Invalid.new(error.text)
      else
        raise OAS::Error.new(error.text)
      end
    end
  end
end
require 'nokogiri'
require 'nori'

module OAS
  class Response
    class Error < OAS::Error
      attr_reader :error_code

      def initialize(error_code, message)
        @error_code = error_code
        super(message)
      end
    end

    def initialize(doc)
      @doc = Nokogiri.XML(doc)
      _validate!
    end

    def parser
      @parser ||= Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.to_sym })
    end
    attr_writer :parser

    def to_s
      @doc.to_xml
    end
    alias_method :to_xml, :to_s

    def to_hash
      @hash ||= parser.parse(@doc.to_xml)
    end
  
    private

    def _validate!
      errors = @doc.xpath('//AdXML/Response//Exception')
      return if errors.empty?
      error = errors.first
      raise OAS::Response::Error.new(error['errorCode'].to_i, error.text)
    end
  end
end
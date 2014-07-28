require 'nokogiri'

module OAS
  class AdXML
    def self.parse(str)
      new Nokogiri.XML(str)
    end

    module Utils
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
    end

    class Request
      def initialize(root)
        @root = root
      end

      def method_missing method, *args, &block # :nodoc:
        Nokogiri::XML::Builder.with(@root) do |xml|
          xml.Request(:type => method.to_s) { |xml| block.call(xml) if block_given? }
        end
      end
    end

    class Response
      include Utils

      attr_reader :error_code
      attr_reader :error_text

      def initialize(doc)
        @doc  = doc
        @error_code = @error_text = nil
        error = @doc.xpath('.//Exception').first rescue nil
        if error
          @error_code = error['errorCode'].to_i
          @error_text = error.text
        end
      end

      def success?
        !error_code
      end
    end

    include Utils

    def initialize(doc = nil)
      @doc = doc
      @doc = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml| xml.AdXML }.doc if @doc.nil?
    end

    def http_headers
      @http_headers ||= {}
    end
    attr_writer :http_headers

    def request
      yield Request.new(@doc.root)
    end

    def response
      responses.first
    end

    def responses
      @responses ||= begin
        res = []
        @doc.xpath('/AdXML/Response').each { |node| res << Response.new(node) }
        res
      end
    end

    def each_response
      responses.each do |res|
        yield res
      end
    end
  end
end
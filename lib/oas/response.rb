require 'nori'
require 'nokogiri'

module OAS
  class Response
    attr_writer :parser

    def initialize(doc)
      @doc = doc
    end

    def parser
      @parser ||= Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.to_sym })
    end

    def to_s
      raw
    end

    def raw
      @raw ||= begin 
        raw = ""
        @doc.each_line { |l| raw << l.strip }
        raw
      end
    end

    def to_hash
      parser.parse(raw)
    end
  end
end
require 'nokogiri'

module OAS
  class Request
    def initialize
      @builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml| xml.AdXML }
    end

    def method_missing method, *args, &block # :nodoc:
      Nokogiri::XML::Builder.with(@builder.doc.root) do |xml|
        xml.Request(:type => method.to_s) { |xml| block.call(xml) if block_given? }
      end
    end

    def to_xml
      @builder.to_xml
    end
  end
end

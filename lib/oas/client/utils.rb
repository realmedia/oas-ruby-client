module Oas
  class Client
    module Utils
      private
      def build_attributes(xml, attributes = {})
        attributes.each do |key,value|
          if value.is_a?(Hash)
            build_attributes(xml, value)
          else
            xml.send(key.to_sym, value)
          end
        end
      end
    end
  end
end
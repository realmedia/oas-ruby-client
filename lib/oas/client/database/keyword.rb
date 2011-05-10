module Oas
  class Client
    module Database
      # Defines methods related to oas keywords
      module Keyword
        def get_keyword(id)
          request("Keyword") do |xml|
            xml.Database(:action => "read") {
              xml.Keyword {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
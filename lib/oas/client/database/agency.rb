module Oas
  class Client
    module Database
      # Defines methods related to oas agencies
      module Agency
        def get_agency(id)
          request("Agency") do |xml|
            xml.Database(:action => "read") {
              xml.Agency {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
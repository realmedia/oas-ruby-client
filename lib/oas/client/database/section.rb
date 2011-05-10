module Oas
  class Client
    module Database
      # Defines methods related to oas sections
      module Section
        def get_section(id)
          request("Section") do |xml|
            xml.Database(:action => "read") {
              xml.Section {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
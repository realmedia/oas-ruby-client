module Oas
  class Client
    module Database
      # Defines methods related to oas sites
      module Site
        def get_site(id)
          request("Site") do |xml|
            xml.Database(:action => "read") {
              xml.Site {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
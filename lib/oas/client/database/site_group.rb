module Oas
  class Client
    module Database
      # Defines methods related to oas site groups
      module SiteGroup
        def get_site_group(id)
          request("SiteGroup") do |xml|
            xml.Database(:action => "read") {
              xml.SiteGroup {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
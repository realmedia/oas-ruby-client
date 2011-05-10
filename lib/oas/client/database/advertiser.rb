module Oas
  class Client
    module Database
      # Defines methods related to oas advertisers
      module Advertiser
        def get_advertiser(id)
          request("Advertiser") do |xml|
            xml.Database(:action => "read") {
              xml.Advertiser {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
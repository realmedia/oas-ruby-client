module Oas
  class Client
    # Defines methods related to oas campaigns
    module Campaign
      def get_campaign(id)
        request("Campaign") do |xml|
          xml.Campaign(:action => "read") {
            xml.Overview {
              xml.Id id
            }
          }
        end
      end      
    end
  end
end
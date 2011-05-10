module Oas
  class Client
    module Database
      # Defines methods related to oas campaign groups
      module CampaignGroup
        def get_campaign_group(id)
          request("CampaignGroup") do |xml|
            xml.Database(:action => "read") {
              xml.CampaignGroup {
                xml.Id id
              }
            }
          end
        end
      end
    end
  end
end
module Oas
  class Client
    # Defines methods related to oas campaigns
    module Campaigns
      def campaign(id)
        request("Campaign") do |xml|
          xml.Campaign(:action => "read") {
            xml.Overview {
              xml.Id id
            }
          }
        end
      end

      def creative(campaign_id, id)
        request("Creative") do |xml|
          xml.Creative(:action => "read") {
            xml.CampaignId campaign_id
            xml.Id id
          }
        end
      end
    end
  end
end

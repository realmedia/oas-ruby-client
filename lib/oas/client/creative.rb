module Oas
  class Client
    # Defines methods related to oas campaign creatives
    module Creative
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

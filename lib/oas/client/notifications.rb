module Oas
  class Client
    # Defines methods related to oas campaigns
    module Notifications
      def notification(campaign_id, event_name)
        request("Notification") do |xml|
          xml.Notification(:action => "read") {
            xml.CampaignId campaign_id
            xml.EventName event_name
          }
        end
      end
    end
  end
end

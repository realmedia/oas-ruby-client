require 'spec_helper'

describe Oas::Client do
  describe "notification" do
    before(:each) do
      stub_api_call fixture("read_notification.xml")
    end

    it "should return a notification hash for a given campaign_id and event_name" do
      response = Oas.notification("campaign_id", "event_name")
      response.should_not be_nil
      response[:Notification][:CampaignId].should eq("campaign_id")
      response[:Notification][:EventName].should eq("event_name")
    end
  end
end

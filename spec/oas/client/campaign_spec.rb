require 'spec_helper'

describe Oas::Client do
  describe ".get_campaign" do
    before(:each) do
      stub_api_call fixture("read_campaign.xml")
    end

    it "should return a campaign hash for a given id" do
      response = Oas.get_campaign("campaign_id")
      response.should_not be_nil
      response[:Campaign].should be_a(Hash)
    end
  end
end

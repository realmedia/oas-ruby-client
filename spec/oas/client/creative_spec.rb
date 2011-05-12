require 'spec_helper'

describe Oas::Client do
  describe "creative" do
    before(:each) do
      stub_api_call fixture("read_creative.xml")
    end

    it "should return a campaign hash for a given id" do
      response = Oas.creative("campaign_id", "creative_id")
      response.should_not be_nil
      response[:Creative].should be_a(Hash)
      response[:Creative][:CampaignId].should eq("campaign_id")
      response[:Creative][:Id].should eq("creative_id")
    end
  end
end

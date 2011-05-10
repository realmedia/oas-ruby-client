require 'spec_helper'

describe Oas::Client do
  describe ".get_site" do
    before(:each) do
      stub_api_call fixture("read_site.xml")
    end

    it "should return a site hash for a given id" do
      response = Oas.get_site("site_id")
      response.should_not be_nil
      response[:Site].should be_a(Hash)
    end
  end
end

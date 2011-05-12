require 'spec_helper'

describe Oas::Client do
  describe "advertiser" do
    before(:each) do
      stub_api_call fixture("read_advertiser.xml")
    end

    it "should return an advertiser hash for a given id" do
      response = Oas.advertiser("advertiser_id")
      response.should_not be_nil
      response[:Advertiser][:Id].should eq("advertiser_id")
    end
  end

  describe "agency" do
    before(:each) do
      stub_api_call fixture("read_agency.xml")
    end

    it "should return an agency hash for a given id" do
      response = Oas.agency("agency_id")
      response.should_not be_nil
      response[:Agency][:Id].should eq("agency_id")
    end
  end

  describe "campaign_group" do
    before(:each) do
      stub_api_call fixture("read_campaign_group.xml")
    end

    it "should return a campaign_group hash for a given id" do
      response = Oas.campaign_group("campaign_group_id")
      response.should_not be_nil
      response[:CampaignGroup][:Id].should eq("campaign_group_id")
    end
  end

  describe "keyname" do
    before(:each) do
      stub_api_call fixture("read_keyname.xml")
    end

    it "should return a keyname hash for a given id" do
      response = Oas.keyname("keyname_name")
      response.should_not be_nil
      response[:Keyname][:Name].should eq("keyname_name")
    end
  end

  describe "keyword" do
    before(:each) do
      stub_api_call fixture("read_keyword.xml")
    end

    it "should return a keyword hash for a given id" do
      response = Oas.keyword("keyword_id")
      response.should_not be_nil
      response[:Keyword][:Id].should eq("keyword_id")
    end
  end

  describe "page" do
    before(:each) do
      stub_api_call fixture("read_page.xml")
    end

    it "should return a page hash for a given id" do
      response = Oas.page("page_url")
      response.should_not be_nil
      response[:Page][:Url].should eq("page_url")
    end
  end

  describe "section" do
    before(:each) do
      stub_api_call fixture("read_section.xml")
    end

    it "should return a section hash for a given id" do
      response = Oas.section("section_id")
      response.should_not be_nil
      response[:Section][:Id].should eq("section_id")
    end
  end

  describe "site" do
    before(:each) do
      stub_api_call fixture("read_site.xml")
    end

    it "should return a site hash for a given id" do
      response = Oas.site("site_id")
      response.should_not be_nil
      response[:Site][:Id].should eq("site_id")
    end
  end

  describe "site_group" do
    before(:each) do
      stub_api_call fixture("read_site_group.xml")
    end

    it "should return a site_group hash for a given id" do
      response = Oas.site_group("site_group_id")
      response.should_not be_nil
      response[:SiteGroup][:Id].should eq("site_group_id")
    end
  end
end

OAS API Ruby Gem
====================
A Ruby wrapper for OAS 7.4 API

Installation
------------
    gem install oas

Usage Examples
--------------
    require "rubygems"
    require "oas"

    # All methods require authentication.
    Oas.configure do |config|
      config.endpoint = WSDL_URI
      config.account  = YOUR_OAS_ACCOUNT
      config.username = YOUR_USERNAME
      config.password = YOUR_PASSWORD
    end

    # Read an advertiser
    puts Oas.advertiser("advertiser_id")

    # Read an agency
    puts Oas.agency("agency_id")

    # Read a campaign
    puts Oas.campaign("campaign_id")

    # Read a campaign group
    puts Oas.campaign_group("campaign_group_id")

    # Read a creative
    puts Oas.creative("campaign_id", "creative_id")

    # Read a keyname
    puts Oas.keyname("keyname")

    # Read a keyword
    puts Oas.keyword("keyword_id")

    # Read a notification
    puts Oas.notification("campaign_id", "event_name")

    # Read a page
    puts Oas.page("page_url")

    # Read a section
    puts Oas.section("section_id")

    # Read a site
    puts Oas.site("site_id")

    # Read a site group
    puts Oas.site_group("site_group_id")

    # Reports
    # StartDate defaults to first time in history
    # EndDate defaults to Date.today

    # Get advertiser reports
    puts Oas.advertiser_report("advertiser_id", "Delivery.Advertiser.Base.T602.01,Delivery.Advertiser.Base.T652.01", "2011/01/01", "2011/01/31")

    # Get campaign reports
    puts Oas.campaign_report("campaign_id", "Delivery.Campaign.Base.T154.01")

    # Get section reports
    puts Oas.section_report("section_id", "Delivery.Section.Cookie.T358.01")

    # Get site reports
    puts Oas.site_report("site_id", "Delivery.Site.Base.T258.01")

    # Get Site Performance Reports
    puts Oas.site_performance_report("site_id, other_site_id", "2011/01/01", "2011/01/31")

    # Get Page Priority Reports
    puts Oas.page_priority_report("www.247realmedia.com/home")

    # Get Campaigns Status Report
    puts Oas.campaign_status_report

TODO
------------

* Create and update support on Campaign and Database sections.
* Listings
* Reach and Frequency Reports
* Inventory

Copyright
---------
Copyright (c) 2011 Realmedia LatinAmerica.
See [LICENSE](https://github.com/realmedia/ruby-oas/blob/master/LICENSE) for details.

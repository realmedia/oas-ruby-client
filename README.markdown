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

TODO
------------

* Create and update support on Campaign and Database sections.
* Listings
* Reports
* Inventory

Copyright
---------
Copyright (c) 2011 Realmedia LatinAmerica.
See [LICENSE](https://github.com/realmedia/oas/blob/master/LICENSE) for details.

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

    # Read a campaign
    puts Oas.campaign("oas_campaign_id")

    # Read a creative
    puts Oas.creative("oas_campaign_id", "oas_creative_id")

Copyright
---------
Copyright (c) 2011 Realmedia LatinAmerica.
See [LICENSE](https://github.com/realmedia/oas/blob/master/LICENSE) for details.

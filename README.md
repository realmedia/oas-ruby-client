OAS Ruby Client [![Build Status](https://secure.travis-ci.org/realmedia/oas-ruby-client.png)][travis] [![Dependency Status](https://gemnasium.com/realmedia/oas-ruby-client.png?travis)][gemnasium]
================
Ruby client for the OpenAdstream API

[travis]: http://travis-ci.org/realmedia/oas-ruby-client
[gemnasium]: https://gemnasium.com/realmedia/oas-ruby-client

Installation
------------

`oas` is available through [Rubygems](http://rubygems.org/gems/oas) and can be installed via:

    gem install oas

Usage Example
--------------
    require "oas"

    # All requests require authentication.
    OAS.configure do |config|
      config.endpoint = WSDL_URI
      config.account  = YOUR_OAS_ACCOUNT
      config.username = YOUR_USERNAME
      config.password = YOUR_PASSWORD
    end

    # Execute API request
    puts OAS.client.request('Site') do |xml|
      xml.Database(:action => 'list') {
        xml.SearchCriteria {
          xml.Id "%"
        }
      }
    end.inspect

Copyright
---------
Copyright (c) 2011 Realmedia Latin America.
See [LICENSE](https://github.com/realmedia/oas-ruby-client/blob/master/LICENSE) for details.
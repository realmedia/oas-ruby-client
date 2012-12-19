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

    # Configure OAS
    OAS.configure do |config|
      config.endpoint = OAS_ENDPOINT
      config.account  = OAS_ACCOUNT
      config.username = OAS_USERNAME
      config.password = OAS_PASSWORD
    end

    # Build OAS message (Ex: Nokogiri)
    msg = Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
      xml.AdXML {
        xml.Request(:type => 'Site') {
          xml.Database(:action => 'list') {
            xml.SearchCriteria {
              xml.Id "%"
            }
          }
        }
      }
    end

    # Make request
    puts OAS.client.request(msg)
    *"<AdXML><Response>.....</Response></AdXML>"*

Copyright
---------
Copyright (c) 2011 Realmedia Latin America.
See [LICENSE](https://github.com/realmedia/oas-ruby-client/blob/master/LICENSE) for details.

# OAS Ruby Client [![Build Status](https://secure.travis-ci.org/realmedia/oas-ruby-client.png)][travis] [![Dependency Status](https://gemnasium.com/realmedia/oas-ruby-client.png?travis)][gemnasium]
Ruby client for the OpenAdstream API

[travis]: http://travis-ci.org/realmedia/oas-ruby-client
[gemnasium]: https://gemnasium.com/realmedia/oas-ruby-client

## Installation

`oas` is available through [Rubygems](http://rubygems.org/gems/oas) and can be installed via:

    gem install oas

## Usage

Applications that make requests on behalf a single user to a single account can pass configuration options as a block to the `OAS.configure` method.

```ruby
OAS.configure do |config|
  config.endpoint = OAS_ENDPOINT
  config.account  = OAS_ACCOUNT
  config.username = OAS_USERNAME
  config.password = OAS_PASSWORD
end
```
Applications that make requests on behalf of multiple users to multiple accounts should avoid using the global configuration and instantiate `OAS::Client` objects. If the endpoint is the same, you can specify it globally.

```ruby
OAS.configure do |config|
  config.endpoint = OAS_ENDPOINT
end

client = OAS::Client.new(
  :account  => "oas_account",
  :username => "oas_username",
  :password => "oas_password"
)
```
Requests should be created using an `OAS::AdXML` object. Each request type will yield a `Nokogiri::XML::Builder` object.

```ruby
doc = OAS::AdXML.new
doc.request do |req|
  req.Advertiser do |xml|
    xml.Database(:action => 'read') {
      xml.Advertiser {
        xml.Id "DPadvtest"
      }
    }
  end
end
```
Multiple requests can be sent in the same call.

```ruby
doc = OAS::AdXML.new
doc.request do |req|
  req.Site do |xml|
    xml.Database(:action => "read") {
      xml.Site {
        xml.Id "247media"
      }
    }
  end
  req.Site do |xml|
    xml.Database(:action => "read") {
      xml.Site {
        xml.Id "realmedia"
      }
    }
  end
end
```
Executing the request

```ruby
adxml = OAS.execute(doc) # or client.execute(doc)
adxml.each_response do |res|
  if res.success?
    # res.to_hash
  else
    # res.error_code
    # res.error_text
  end
end
```

## Copyright
Copyright (c) 2011 Realmedia Latin America.
See [LICENSE](https://github.com/realmedia/oas-ruby-client/blob/master/LICENSE) for details.

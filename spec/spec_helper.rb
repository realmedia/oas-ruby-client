require 'oas'
require 'rspec'
require "webmock/rspec"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include WebMock::API
  config.before(:each) { stub_wsdl }
  config.after(:each) { Oas.reset }
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def stub_wsdl(status = 200)
  stub_request(:get, Oas.endpoint).to_return(:status => status, :body => fixture("wsdl.xml"))
end

def stub_api_call(body = nil, status = 200)
  stub_request(:post, "https://oas.realmedianetwork.net:443/oasapi/OaxApi").to_return(:status => status, :body => body, :headers => {:content_type => "text/xml;charset=utf-8"})
end

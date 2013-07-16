require 'helper'
require 'webmock'

class TestClient < MiniTest::Unit::TestCase
  include WebMock::API

  def setup
    @client  = OAS::Client.new(
      :account  => "test_account",
      :username => "test_user",
      :password => "test_password"
    )
    @request = Class.new do
      def to_xml; '<AdXML></AdXML>' end
    end.new
  end

  def teardown
    OAS.reset!
    WebMock.reset!
  end

  def fixture(file)
    File.new(File.join(File.expand_path('../fixtures', __FILE__), file))
  end

  def test_execute_request
    stub_request(:post, @client.endpoint.to_s)
      .to_return(:status => 200, :body => fixture('response.xml'))

    assert_kind_of OAS::AdXML, @client.execute(@request)
    assert_requested(:post, @client.endpoint.to_s, :times => 1) do |req| 
      doc = Nokogiri.XML(req.body)
      node = doc.xpath("/env:Envelope/env:Body/n1:OasXmlRequest").first
      return false unless !!node
      node.xpath("./String_1").first.text == @client.account && 
      node.xpath("./String_2").first.text == @client.username &&
      node.xpath("./String_3").first.text == @client.password &&
      node.xpath("./String_4").first.text == @request.to_xml
    end
  end


  def test_raise_http_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 599)

    assert_raises OAS::Error::HTTP do
      @client.execute(@request)
    end
  end

  def test_raise_http_forbidden_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 403)

    assert_raises OAS::Error::HTTP::Forbidden do
      @client.execute(@request)
    end
  end

  def test_raise_http_internal_server_error_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 500)

    assert_raises OAS::Error::HTTP::InternalServerError do
      @client.execute(@request)
    end
  end

  def test_raise_http_bad_gateway_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 502)

    assert_raises OAS::Error::HTTP::BadGateway do
      @client.execute(@request)
    end
  end

  def test_raise_http_service_unavailable_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 503)

    assert_raises OAS::Error::HTTP::ServiceUnavailable do
      @client.execute(@request)
    end
  end

  def test_raise_http_gateway_timeout_error
    stub_request(:post, @client.endpoint.to_s).to_return(:status => 504)

    assert_raises OAS::Error::HTTP::GatewayTimeout do
      @client.execute(@request)
    end
  end
end
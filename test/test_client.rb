require 'helper'

class TestClient < MiniTest::Unit::TestCase
  def setup
    @client  = OAS::Client.new
    @request = Class.new do
      def to_xml; '<AdXML></AdXML>' end
    end.new
  end

  def teardown
    OAS.reset!
  end

  def test_make_oas_call
    res = Class.new do
      def body; { :oas_xml_request_response => { :result => '<AdXML></AdXML>' } } end
    end.new
    @client.driver = MiniTest::Mock.new
    @client.driver.expect :call, res, [:oas_xml_request, message: Hash['String_1', @client.account.to_s, 'String_2', @client.username.to_s, 'String_3', @client.password.to_s, 'String_4', @request.to_xml.to_s]]
    @client.execute(@request)
    @client.driver.verify
  end

  def test_return_response_object
    mock_driver = Class.new do
      def call(*args)
        Class.new do
          def body; { :oas_xml_request_response => { :result => '<AdXML></AdXML>' } } end
        end.new
      end
    end.new

    @client.driver = mock_driver
    assert_kind_of OAS::Response, @client.execute(@request)
  end
end
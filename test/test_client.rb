require 'helper'

class TestClient < MiniTest::Unit::TestCase
  def setup
    @client = OAS::Client.new
  end

  def teardown
    OAS.reset!
  end

  def test_call_with_string_xml
    res = Class.new do
      def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
    end.new
    @client.driver = MiniTest::Mock.new
    @client.driver.expect :call, res, [:oas_xml_request, message: Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", "<AdXML></AdXML>"]]
    @client.request("<AdXML></AdXML>")
    @client.driver.verify
  end

  def test_call_with_object_respond_to_xml
    doc = Class.new do
      def to_xml; "<AdXML></AdXML>" end
    end.new
    res = Class.new do
      def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
    end.new
    @client.driver = MiniTest::Mock.new
    @client.driver.expect :call, res, [:oas_xml_request, message: Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", doc.to_xml]]
    @client.request(doc)
    @client.driver.verify
  end

  def test_return_response_object
    mock_driver = Class.new do
      def call(*args)
        Class.new do
          def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
        end.new
      end
    end.new

    @client.driver = mock_driver
    assert_kind_of OAS::Response, @client.request("<AdXML></AdXML>")
  end
end
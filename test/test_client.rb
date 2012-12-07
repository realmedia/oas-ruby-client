require 'helper'

class TestClient < MiniTest::Unit::TestCase
  def setup
    @client = OAS::Client.new
  end

  def teardown
    OAS.reset!
  end

  def test_yield_xml_builder
    @client.driver = Class.new do
      def request(*args)
        Class.new do
          def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
        end.new
      end
    end.new

    yielded = nil
    @client.request { |xml| yielded = xml }
    refute_nil yielded
    assert_kind_of Nokogiri::XML::Builder, yielded
  end

  def test_raise_argument_error
    assert_raises ArgumentError do
      @client.request("<AdXML></AdXML>")
    end
  end

  def test_make_request_with_given_argument
    msg = Nokogiri::XML::Builder.new(encoding: 'UTF-8') { |xml| xml.AdXML }
    res = Class.new do
      def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
    end.new
    body = Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", msg.to_xml]
    @client.driver = MiniTest::Mock.new
    @client.driver.expect :request, res, [:n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]]
    doc = @client.request(msg)
    @client.driver.verify
    assert_kind_of Nokogiri::XML::Document, doc
    assert_equal "AdXML", doc.root.name
  end

  def test_make_request_with_given_block
    msg = Nokogiri::XML::Builder.new(encoding: 'UTF-8') { |xml| xml.AdXML }
    res = Class.new do
      def body; { :oas_xml_request_response => { :result => "<AdXML></AdXML>" } } end
    end.new
    body = Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", msg.to_xml]
    @client.driver = MiniTest::Mock.new
    @client.driver.expect :request, res, [:n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]]
    @client.request { |xml| xml.AdXML }
    @client.driver.verify
  end
end
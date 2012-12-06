require 'helper'

class TestClient < MiniTest::Unit::TestCase
  def setup
    @client = OAS::Client.new
  end

  def teardown
    OAS.reset!
  end

  def test_make_valid_oas_soap_request
    msg = Nokogiri::XML::Document.parse("<AdXML></AdXML>")
    res = Class.new do
      def hash
        { :Envelope => { :Body => { :OasXmlRequestResponse => { :result => "<AdXML></AdXML>" } } } }
      end
    end
    body = Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", msg.to_xml]
    mock_cli = MiniTest::Mock.new
    mock_cli.expect :request, res.new, [:n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]]
    @client.soap_client = mock_cli
    response = @client.request(msg)
    mock_cli.verify
    assert_kind_of Hash, response
    assert response.has_key?(:AdXML)
  end

  def test_raise_argument_error
    assert_raises ArgumentError do
      @client.request("<AdXML></AdXML>")
    end
  end
end
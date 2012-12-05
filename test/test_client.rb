require 'helper'

class TestClient < MiniTest::Unit::TestCase
  def setup
    @client = OAS::Client.new
  end

  def teardown
    OAS.reset!
  end

  def test_make_valid_oas_soap_request
    req = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |doc|
      doc.AdXML {
        doc.Request(type: "type") {
          doc.Database(action: "read")
        }
      }
    end.to_xml
    res = {
      oas_xml_request_response: {
        result: "<AdXML><Response></Response></AdXML>"
      }
    }
    body = Hash["String_1", @client.account.to_s, "String_2", @client.username.to_s, "String_3", @client.password.to_s, "String_4", req]
    mock_cli = MiniTest::Mock.new
    mock_cli.expect :request, res, [:n1, :oas_xml_request, Hash["xmlns:n1", "http://api.oas.tfsm.com/", :body, body]]
    @client.soap_client = mock_cli
    response = @client.request("type") do |xml|
      xml.Database(action: "read")
    end
    mock_cli.verify
    assert_kind_of Hash, response
    assert response.has_key?(:AdXML)
    assert response[:AdXML].has_key?(:Response)
  end
end
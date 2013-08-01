require 'helper'

class TestAdXMLResponse < MiniTest::Unit::TestCase
  def test_successful_response
    node = <<-EOXML
    <AdXML>
      <Response>
        <Campaign>
          <Overview>
            <Id>DPtestcampaign-01</Id>
          </Overview>
        </Campaign>
      </Response>
    </AdXML>
    EOXML
    res = OAS::AdXML::Response.new Nokogiri.XML(node).xpath('/AdXML/Response').first
    assert res.to_hash.has_key?(:Response)
    assert res.success?
    assert_nil res.error_code
    assert_nil res.error_text
  end

  def test_unsuccessful_response
    node = <<-EOXML
    <AdXML>
      <Response>
        <Campaign>
          <Exception errorCode="512">Campaign ID already exists in Open AdStream</Exception>
        </Campaign>
      </Response>
    </AdXML>
    EOXML
    res = OAS::AdXML::Response.new Nokogiri.XML(node).xpath('/AdXML/Response').first
    refute res.success?
    assert_equal 512, res.error_code
    assert_equal 'Campaign ID already exists in Open AdStream', res.error_text
  end
end
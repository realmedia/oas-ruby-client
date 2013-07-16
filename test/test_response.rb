require 'helper'

class TestResponse < MiniTest::Unit::TestCase
  def setup
    doc = <<-EOXML
    <AdXML>
      <Response>
      </Response>
    </AdXML>
    EOXML

    @response = OAS::Response.new(doc)
  end

  def test_convert_to_hash
    assert @response.to_hash.has_key?(:AdXML)
    assert @response.to_hash[:AdXML].has_key?(:Response)
  end

  def test_raise_response_error
    doc = <<-EOXML
    <AdXML>
      <Response>
        <Campaign>
          <Exception errorCode="512">Campaign ID already exists in Open AdStream</Exception>
        </Campaign>
      </Response>
    </AdXML>
    EOXML

    e = assert_raises OAS::Response::Error do 
      OAS::Response.new(doc)
    end
    assert_equal 512, e.error_code
    assert_equal 'Campaign ID already exists in Open AdStream', e.message
  end
end
require 'helper'

class TestResponse < MiniTest::Unit::TestCase
  def test_convert_to_hash
    doc = <<-EOXML
    <AdXML>
      <Response>
      </Response>
    </AdXML>
    EOXML

    res = OAS::Response.new(doc)
    assert res.to_hash.has_key?(:AdXML)
    assert res.to_hash[:AdXML].has_key?(:Response)
  end

  def test_raise_oas_error
    doc = <<-EOXML
    <AdXML>
      <Response>
        <Campaign>
          <Exception errorCode="512">Campaign ID already exists in Open AdStream</Exception>
        </Campaign>
      </Response>
    </AdXML>
    EOXML

    assert_raises OAS::Error::DuplicateId do
      res = OAS::Response.new(doc)
    end
  end
end
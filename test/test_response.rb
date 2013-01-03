require 'helper'

class TestResponse < MiniTest::Unit::TestCase
  def setup
    doc = <<EOF
    <AdXML>
      <Response>
      </Response>
    </AdXML>
EOF
    @response = OAS::Response.new(doc)
  end

  def test_convert_to_hash
    assert @response.to_hash.has_key?(:AdXML)
    assert @response.to_hash[:AdXML].has_key?(:Response)
  end

  def test_convert_to_string_without_spaces_and_line_breaks
    assert_equal "<AdXML><Response></Response></AdXML>", @response.to_s
  end
end
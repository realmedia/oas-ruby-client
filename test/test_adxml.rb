require 'helper'

class TestAdXML < MiniTest::Unit::TestCase
  def setup
    @doc = OAS::AdXML.new
  end

  def test_set_encoding
    assert_match 'UTF-8', @doc.to_xml
  end

  def test_set_root_node
    new_doc = Nokogiri.XML @doc.to_xml
    assert_equal 'AdXML', new_doc.root.name
  end

  def test_convert_to_hash
    assert @doc.to_hash.has_key?(:AdXML)
  end

  def test_adxml_parsing
    assert_kind_of OAS::AdXML, OAS::AdXML.parse("<AdXML></AdXML>")
  end

  def test_response_iterator
    str = <<-EOXML
    <AdXML>
      <Response>
        <Campaign/>
      </Response>
      <Response>
        <Campaign/>
      </Response>
    </AdXML>
    EOXML
    responses = []
    doc = OAS::AdXML.new Nokogiri.XML(str)
    doc.each_response do |res|
      responses << res
      assert_kind_of OAS::AdXML::Response, res
      assert_equal 'Response', Nokogiri.XML(res.to_xml).root.name
    end
    assert_equal 2, responses.size
  end

  def test_request_builder
    @doc.request do |req|
      req.Site do |xml|
        assert_kind_of Nokogiri::XML::Builder, xml
      end
    end

    new_doc = Nokogiri.XML(@doc.to_xml)
    assert_equal 1, new_doc.xpath("/AdXML/Request[@type='Site']").length
  end

  def test_chain_request_blocks
    @doc.request do |req|
      req.Site
      req.Site
    end
    @doc.request do |req|
      req.Campaign
    end

    new_doc = Nokogiri.XML(@doc.to_xml)
    assert_equal 3, new_doc.xpath('/AdXML/Request').length
  end
end
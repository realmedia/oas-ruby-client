require 'helper'

class TestRequest < MiniTest::Unit::TestCase
  def setup
    @request = OAS::Request.new
  end

  def test_build_with_encoding
    assert_match 'UTF-8', @request.to_xml
  end

  def test_build_root_node
    doc = Nokogiri.XML(@request.to_xml)
    assert_equal 'AdXML', doc.root.name
  end

  def test_build_request_block_with_type_attribute
    @request.Site do |xml|
      assert_kind_of Nokogiri::XML::Builder, xml
    end

    doc = Nokogiri.XML(@request.to_xml)
    assert_equal 1, doc.xpath("//AdXML//Request[@type='Site']").length
  end

  def test_chain_request_blocks
    @request.Site
    @request.Site

    doc = Nokogiri.XML(@request.to_xml)
    assert_equal 2, doc.xpath('//AdXML//Request').length
  end
end
require 'helper'
require 'oas/model'

class Site < OAS::Model
  attribute :Name

  def validate
    assert_present :Name
  end
end

class Page < OAS::Model
  identifier :Url
end

class Advertiser < OAS::Model
  attribute :Name
end

class Campaign < OAS::Model
  reference :Advertiser
  attribute :ScheduledImpressions, lambda { |v| v.to_i }
end

class TestModel < MiniTest::Test
  def test_identifier_defaults_to_id
    site = Site.new
    site.id = "github"
    assert site.attrs.has_key?(:Id)
  end

  def test_custom_identifier
    page = Page.new
    page.url = "github.com/home"
    assert_equal page.url, page.id
    assert page.attrs.has_key?(:Url)
    assert !page.attrs.has_key?(:Id)
  end

  def test_assign_attributes_from_hash
    site = Site.new(:Name => "Sportive LA")
    assert_equal "Sportive LA", site.name
  end

  def test_ignore_assigment_of_undefined_attributes
    site = Site.new(:Owner => "Jhon Doe")
    assert !site.attrs.has_key?(:Owner)
  end

  def test_load_model_by_identifier
    client = Class.new do
      def request(msg)
        { :AdXML => {
            :Response => {
              :Site => {
                :Id => 'github.com',
                :Name => 'GitHub',
                :WhenCreated => '05/25/2010 11:44:00'
              }
            }
          }
        }
      end
    end.new

    Site.client = client
    site = Site['github.com']
    assert_equal 'github.com', site.id
    assert_equal 'GitHub', site.name
  end

  def test_update_attributes
    site = Site.new(:Name => "Sportive LA")
    site.update_attributes(:name => "Sportive EU")
    assert_equal "Sportive EU", site.name
  end

  def test_typecast_attribute
    campaign = Campaign.new(:ScheduledImpressions => "10500")
    assert_equal 10500, campaign.scheduled_impressions
  end

  def test_raise_error_if_validation_fails
    site = Site.new(:Id => "github")
    assert_raises OAS::Error::Invalid do
      site.update(:Id => nil)
    end
  end

  def test_reload_after_save
    client = Class.new do
      def request(msg)
        { :AdXML => {
            :Response => [
              { :Page => "Successfully added" },
              { :Page => { :Url => 'github.com/home', :WhenCreated => '05/25/2010 11:44:00' } }
            ]
          }
        }
      end
    end.new

    Page.client = client
    page = Page.new(:Id => "github.com/home")
    page.save
    refute_nil page.created_at
    assert !page.new?
  end

  def test_association_reference
    a = Advertiser.new(:Id => "realmedia")
    c = Campaign.new(:Id => "test_campaign", :Advertiser => a)

    assert_equal a, c.advertiser
    assert_equal a.id, c.advertiser_id
    assert c.attrs.has_key?(:AdvertiserId)
  end
end
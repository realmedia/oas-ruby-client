require 'helper'
require 'oas/publisher'

class TestPublisher < MiniTest::Test
  def setup
    OAS.configure do |c|
      c.username = 'apiuser'
    end
    @publisher = OAS::Publisher.new(:Id => 'newpublisher')
  end

  def test_payment_method_defaults_to_transfer
    assert_equal 'T', @publisher.payment_method
  end

  def test_currency_defaults_to_usd
    assert_equal 'USD', @publisher.currency
  end

  def test_account_manager_defaults_to_api_user
    assert_equal 'apiuser', @publisher.account_manager
  end

  def test_publisher_actions_defaults_to_false
    refute @publisher.receive_approval_email
    refute @publisher.decline_creative
    refute @publisher.view_campaign_rate
    refute @publisher.view_earned_revenue
  end

  def test_quick_reports_defaults_to_short
    assert_equal 'short', @publisher.internal_quick_report
    assert_equal 'short', @publisher.internal_quick_report
  end

  def test_validates_presence_of_external_users
    client = Class.new do
      def username; 'apiuser' end
      def request(*args); {:AdXML => {:Response => [{ :Publisher => {:Id => 'newpublisher', :WhenCreated => Time.now.strftime("%m/%d/%Y %H:%M:%S") } }] }} end
    end.new

    OAS::Publisher.client = client
    @publisher.external_users = []

    assert_raises OAS::Error::Invalid do
      @publisher.save
    end
    assert_equal [:not_present], @publisher.errors[:ExternalUsers]
  end
end
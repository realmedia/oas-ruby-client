require 'helper'
require 'oas/site'

class TestSite < MiniTest::Test
  def setup
    @site = OAS::Site.new(:Id => 'Test99', :Domain => 'Test99.com')
  end

  def teardown
    OAS.network = false
  end

  def test_payment_method_defaults_to_transfer
    assert_equal 'T', @site.payment_method
  end

  def test_pay_to_defaults_to_site
    assert_equal 'S', @site.pay_to
  end

  def test_currency_defaults_to_usd
    assert_equal 'USD', @site.currency
  end
end
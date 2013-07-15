require 'helper'

class TestConfiguration < MiniTest::Unit::TestCase
  def test_should_set_configuration_keys
    OAS::Configuration::VALID_OPTIONS_KEYS.each do |key|
      OAS.configure do |config|
        config.send("#{key}=", key)
        assert_equal key, OAS.send(key)
      end
    end
  end
end
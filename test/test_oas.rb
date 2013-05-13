require 'helper'

class TestOAS < MiniTest::Test

  describe "#configure" do
    OAS::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        OAS.configure do |config|
          config.send("#{key}=", key)
          assert_equal key, OAS.send(key)
        end
      end
    end
  end
end
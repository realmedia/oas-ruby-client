require 'spec_helper'

describe Oas do
  describe ".configure" do
    Oas::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Oas.configure do |config|
          config.send("#{key}=", key)
          Oas.send(key).should == key
        end
      end
    end
  end
end
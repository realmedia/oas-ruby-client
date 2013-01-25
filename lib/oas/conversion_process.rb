require 'oas/model'

module OAS
  class ConversionProcess < Model
    identifier :Name
    attribute :ConversionProcessType
    attribute :NumberOfSteps, Type::Integer
    attribute :ClickLookBackWindow, Type::Integer
    attribute :ImpressionLookBackWindow, Type::Integer
    attribute :Cpa, Type::Float

    reference :Advertiser

    def publisher_conversion?
      conversion_process_type == 'P'
    end

    def advertiser_conversion?
      conversion_process_type == 'A'
    end

    def validate
      assert_present :ConversionProcessType
      assert_present :NumberOfSteps
      assert_numeric :NumberOfSteps
      assert_present :AdvertiserId if advertiser_conversion?
    end
  end
end
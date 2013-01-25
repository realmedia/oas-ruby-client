require 'oas/model'

module OAS
  class Publisher < Model
    attribute :Description
    attribute :Notes
    attribute :Name
    attribute :FirstName
    attribute :LastName
    attribute :Email
    attribute :Phone
    attribute :Fax
    attribute :Currency
    attribute :PaymentMethod
    attribute :ReceiveApprovalEmail, Type::Boolean
    attribute :DeclineCreative, Type::Boolean
    attribute :ViewCampaignRate, Type::Boolean
    attribute :ViewEarnedRevenue, Type::Boolean

    def validate
      assert_present :Currency
      assert_present :PaymentMethod
      assert_present :ReceiveApprovalEmail
      assert_present :DeclineCreative
      assert_present :ViewCampaignRate
      assert_present :ViewEarnedRevenue
    end
  end
end
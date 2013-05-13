require 'oas/model'

module OAS
  class Publisher < Model
    attribute :AccountManager
    attribute :Currency
    attribute :PaymentMethod
    attribute :ReceiveApprovalEmail, Type::Boolean
    attribute :DeclineCreative,      Type::Boolean
    attribute :ViewCampaignRate,     Type::Boolean
    attribute :ViewEarnedRevenue,    Type::Boolean
    attribute :InternalQuickReport
    attribute :ExternalQuickReport

    def initialize(attrs = {})
      super(attrs)
      self.account_manager ||= client.username
      self.currency ||= 'USD'
      self.payment_method ||= 'T'
      self.receive_approval_email ||= 'N'
      self.decline_creative ||= 'N'
      self.view_campaign_rate ||= 'N'
      self.view_earned_revenue ||= 'N'
      self.internal_quick_report ||= 'short'
      self.external_quick_report ||= 'short'
    end

    def external_users
      @attrs[:ExternalUsers] ||= {}
    end

    def external_users=(user_ids)
      external_users.clear
      [user_ids].flatten.each do |user_id|
        external_users[:UserId] = user_id
      end
    end

    def validate
      assert_present :AccountManager
      assert_present :Currency
      assert_present :PaymentMethod
      assert_present :InternalQuickReport
      assert_present :ExternalQuickReport
      assert external_users.length > 0, [:ExternalUsers, :not_present]
      assert_member :Currency, ['USD', 'EUR', 'GBP', 'CHF', 'CZK', 'DKK', 'HUF', 'NOK', 'PLN', 'SEK', 'SKK', 'TRL', 'CAD', 'RMB', '$']
      assert_member :InternalQuickReport, ['short', 'to-date']
      assert_member :ExternalQuickReport, ['short', 'to-date']
    end
  end
end
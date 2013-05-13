require 'oas/model'

module OAS
  class Site < Model
    attribute :Name
    attribute :Domain
    attribute :Notes
    attribute :ECPMFloorRate,     Type::Float
    attribute :CommissionPercent, Type::Integer
    attribute :AffiliateCPM,      Type::Float
    attribute :AffiliateCPC,      Type::Float
    attribute :ServingFee,        Type::Float
    attribute :ServiceFee,        Type::Float
    attribute :Currency
    attribute :PayTo
    attribute :PaymentMethod

    reference :Publisher

    def initialize(attrs = {})
      super(attrs)
      self.currency ||= 'USD'
      self.pay_to   ||= 'S'
      self.payment_method ||= 'T'
    end

    def validate
      assert_present :Domain
      if OAS.network?
        assert_present :PayTo
        assert_present :PublisherId
      end
      assert_member :Currency, ['USD', 'EUR', 'GBP', 'CHF', 'CZK', 'DKK', 'HUF', 'NOK', 'PLN', 'SEK', 'SKK', 'TRL', 'CAD', 'RMB', '$']
      assert_member :PayTo, ['S', 'P']
      assert_member :PaymentMethod, ['C', 'B', 'I', 'T']
    end
  end
end
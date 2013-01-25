require 'oas/model'

module OAS
  class Site < Model
    attribute :Name
    attribute :Domain
    attribute :Notes
    attribute :ECPMFloorRate, Type::Float
    attribute :CommissionPercent, Type::Integer
    attribute :AffiliateCPM, Type::Float
    attribute :AffiliateCPC, Type::Float
    attribute :ServingFee, Type::Float
    attribute :ServiceFee, Type::Float
    attribute :Currency
    attribute :PayTo
    attribute :PaymentMethod

    reference :Publisher

    def validate
      assert_present :Domain
    end
  end
end
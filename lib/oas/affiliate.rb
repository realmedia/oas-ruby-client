require 'oas/model'

module OAS
  class Affiliate < Model
    indentifier :Name
    attribute :AffiliateType

    def validate
      assert_present :AffiliateType
    end
  end
end
require 'oas/model'

module OAS
  class Advertiser < Model
    attribute :Organization
    attribute :Notes
    attribute :ContactFirstName
    attribute :ContactLastName
    attribute :ContactTitle
    attribute :Email
    attribute :Phone
    attribute :Fax

    def validate
      assert_present :Organization
    end
  end
end
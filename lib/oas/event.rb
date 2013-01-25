require 'oas/model'

module OAS
  class Event < Model
    identifier :Name
    attribute :EventType
    attribute :Active, Type::Boolean

    def validate
      assert_present :EventType
      assert_present :Active
    end
  end
end
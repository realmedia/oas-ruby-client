require 'oas/model'

module OAS
  class Transaction < Model
    attribute :Name
    attribute :NumberOfSteps, Type::Integer
    attribute :TransactionType
    attribute :RevenueAction
  end
end
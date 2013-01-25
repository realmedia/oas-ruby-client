require 'oas/model'

module OAS
  class Page < Model
    identifier :Url
    reference :Site
    attribute :Description
  end
end
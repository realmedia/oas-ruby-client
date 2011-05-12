module Oas
  class Client < Api
    require 'oas/client/utils'
    require 'oas/client/campaign'
    require 'oas/client/creative'
    require 'oas/client/database'
    require 'oas/client/notification'
    
    include Oas::Client::Utils
    include Oas::Client::Campaign
    include Oas::Client::Creative
    include Oas::Client::Database
    include Oas::Client::Notification
  end
end

module Oas
  class Client < Api
    class Error < StandardError; end

    require 'oas/client/utils'
    require 'oas/client/campaigns'
    require 'oas/client/databases'
    require 'oas/client/notifications'
    require 'oas/client/reports'
    
    include Oas::Client::Utils
    include Oas::Client::Campaigns
    include Oas::Client::Databases
    include Oas::Client::Notifications
    include Oas::Client::Reports
  end
end

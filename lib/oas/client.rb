module Oas
  class Client < Api
    require 'oas/client/utils'
    require 'oas/client/campaign'
    require 'oas/client/creative'
    require 'oas/client/database/advertiser'
    require 'oas/client/database/agency'
    require 'oas/client/database/campaign_group'
    require 'oas/client/database/keyname'
    require 'oas/client/database/keyword'
    require 'oas/client/database/page'
    require 'oas/client/database/section'
    require 'oas/client/database/site'
    require 'oas/client/database/site_group'
    
    include Oas::Client::Utils
    include Oas::Client::Campaign
    include Oas::Client::Creative
    include Oas::Client::Database::Advertiser
    include Oas::Client::Database::Agency
    include Oas::Client::Database::CampaignGroup
    include Oas::Client::Database::Keyname
    include Oas::Client::Database::Keyword
    include Oas::Client::Database::Page
    include Oas::Client::Database::Section
    include Oas::Client::Database::Site
    include Oas::Client::Database::SiteGroup
  end
end
module Oas
  class Client
    # Defines methods related to oas database section
    module Database
      def advertiser(id)
        request("Advertiser") do |xml|
          xml.Database(:action => "read") {
            xml.Advertiser {
              xml.Id id
            }
          }
        end
      end

      def agency(id)
        request("Agency") do |xml|
          xml.Database(:action => "read") {
            xml.Agency {
              xml.Id id
            }
          }
        end
      end

      def campaign_group(id)
        request("CampaignGroup") do |xml|
          xml.Database(:action => "read") {
            xml.CampaignGroup {
              xml.Id id
            }
          }
        end
      end

      def keyname(name)
        request("Keyname") do |xml|
          xml.Database(:action => "read") {
            xml.Keyname {
              xml.Name name
            }
          }
        end
      end

      def keyword(id)
        request("Keyword") do |xml|
          xml.Database(:action => "read") {
            xml.Keyword {
              xml.Id id
            }
          }
        end
      end

      def page(url)
        request("Page") do |xml|
          xml.Database(:action => "read") {
            xml.Page {
              xml.Url url
            }
          }
        end
      end

      def section(id)
        request("Section") do |xml|
          xml.Database(:action => "read") {
            xml.Section {
              xml.Id id
            }
          }
        end
      end

      def site(id)
        request("Site") do |xml|
          xml.Database(:action => "read") {
            xml.Site {
              xml.Id id
            }
          }
        end
      end

      def site_group(id)
        request("SiteGroup") do |xml|
          xml.Database(:action => "read") {
            xml.SiteGroup {
              xml.Id id
            }
          }
        end
      end
    end
  end
end

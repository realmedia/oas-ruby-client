module Oas
  class Client
    # Defines methods related to oas reports section
    module Reports
      class MissingTablesError < Client::Error; end

      def advertiser_report(advertiser_id, report_ids, start_date = nil, end_date = Date.today)
        report_request("Advertiser", advertiser_id, report_ids, start_date, end_date)
      end

      def campaign_report(campaign_id, report_ids, start_date, end_date = Date.today)
        report_request("Campaign", campaign_id, report_ids, start_date, end_date)
      end

      def section_report(section_id, report_ids, start_date = nil, end_date = Date.today)
        report_request("Section", site_id, report_ids, start_date, end_date)
      end

      def site_report(site_id, report_ids, start_date = nil, end_date = Date.today)
        report_request("Site", site_id, report_ids, start_date = Date.today, end_date)
      end

      def site_performance_report(site_ids = "", start_date = nil, end_date = Date.today)
        request("SitePerformanceReport") do |xml|
          xml.SitePerformanceReport {
            xml.Ids {
              site_ids.split(",").each do |s|
                xml.Id s
              end
            }
            xml.StartDate start_date
            xml.EndDate end_date
            xml.Table "Performance.Site.Base.T100.03"
          }
        end
      end

      def page_priority_report(page_url)
        request("PagePriorityReport") do |xml|
          xml.PagePriorityReport {
            xml.Id page_url
            xml.Table "Delivery.Page.Base.T100.05"
          }
        end
      end

      def campaign_status_report
        request("StatusReport") do |xml|
          xml.StatusReport(:type => "Campaign") {
            xml.Table "ImpressionCampaignStatusDetail"
          }
        end
      end

      private
      def report_request(type, id, report_ids, start_date, end_date)
        raise NoReportTablesError.new if report_ids.blank?
        request("Report") do |xml|
          xml.Report(:type => type) {
            xml.Id id
            xml.StartDate start_date
            xml.EndDate end_date
            report_ids.split(",").each do |r|
              xml.Table r
            end
          }
        end
      end
    end
  end
end

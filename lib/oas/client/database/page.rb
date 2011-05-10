module Oas
  class Client
    module Database
      # Defines methods related to oas pages
      module Page
        def get_page(url)
          request("Page") do |xml|
            xml.Database(:action => "read") {
              xml.Page {
                xml.Url url
              }
            }
          end
        end
      end
    end
  end
end
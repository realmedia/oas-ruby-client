module Oas
  class Client
    module Database
      # Defines methods related to oas keynames
      module Keyname
        def get_keyname(name)
          request("Keyname") do |xml|
            xml.Database(:action => "read") {
              xml.Keyname {
                xml.Name name
              }
            }
          end
        end
      end
    end
  end
end
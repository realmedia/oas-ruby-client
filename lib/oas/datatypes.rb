require "bigdecimal"
require "date"

module OAS
  module DataTypes
    module Type
      Integer   = lambda { |x| x.to_i }
      Decimal   = lambda { |x| BigDecimal(x.to_s) }
      Float     = lambda { |x| x.to_f }
      Boolean   = lambda { |x| OAS::DataTypes.bool(x) }
      Date      = lambda { |d| d && (d.kind_of?(::Date) ? d : ::Date.strptime(d, "%m/%d/%Y")) }
      DateTime  = lambda { |t| t && (t.kind_of?(::DateTime) ? t : ::DateTime.strptime(t, "%m/%d/%Y %H:%M:%S")) }
    end

    def self.bool(val)
      case val
      when "N" then false
      when "Y"  then true
      else
        !! val
      end
    end
  end
end
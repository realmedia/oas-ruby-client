class Object
  # From activesupport/lib/active_support/core_ext/object/blank.rb, line 12
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end
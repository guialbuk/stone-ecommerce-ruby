class ErrorReport

  attr_accessor :Category

  attr_accessor :ErrorItemCollection


  def initialize
    @ErrorItemCollection = Array.new;
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end

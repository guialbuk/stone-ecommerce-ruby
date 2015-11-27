class ErrorItem

  attr_accessor :ErrorCode

  attr_accessor :ErrorField

  attr_accessor :Description

  attr_accessor :SeverityCode

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end
  
end

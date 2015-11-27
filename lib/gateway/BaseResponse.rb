class BaseResponse

  attr_accessor :RequestKey

  attr_accessor :MerchantKey

  attr_accessor :ErrorReport

  attr_accessor :InternalTime

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end

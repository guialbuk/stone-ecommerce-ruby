class Address

  attr_accessor :Country

  attr_accessor :State

  attr_accessor :City

  attr_accessor :District

  attr_accessor :Street

  attr_accessor :Number

  attr_accessor :Complement

  attr_accessor :ZipCode

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
class RetrySaleOptions
  # Indica se o limite extendido est� habilitado
  attr_accessor :ExtendedLimitEnabled

  # C�digo do limite extendido
  attr_accessor :ExtendedLimitCode

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
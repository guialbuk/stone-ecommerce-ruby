class BaseRequest
  # Chave da requisi��o. Utilizada para identificar uma requisi��o espec�fica no gateway.
  attr_accessor :RequestKey

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
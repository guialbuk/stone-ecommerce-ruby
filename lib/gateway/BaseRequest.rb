class BaseRequest
  # Chave da requisição. Utilizada para identificar uma requisição específica no gateway.
  attr_accessor :RequestKey

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
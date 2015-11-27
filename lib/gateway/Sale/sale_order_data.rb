class SaleOrderData
  # N�mero do pedido no sistema da loja
  attr_accessor :OrderReference

  # Chave do pedido. Utilizado para identificar o pedido no Gateway
  attr_accessor :OrderKey

  # Data de cria��o do pedido no Gateway
  attr_accessor :CreateDate

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
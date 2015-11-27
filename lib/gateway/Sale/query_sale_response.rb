class QuerySaleResponse
  # Lista de vendas
  attr_accessor :SaleDataCollection

  # Indicador do total de vendas
  attr_accessor :SaleDataCount

  def initialize
    @SaleDataCollection = Array.new
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
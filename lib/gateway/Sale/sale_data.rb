require_relative 'sale_order_data'

class SaleData
  # Lista transa��es de cart�o de cr�dito
  attr_accessor :CreditCardTransactionDataCollection

  # Lista as transa��es de boleto
  attr_accessor :BoletoTransactionDataCollection

  # Dados do pedido
  attr_accessor :OrderData

  # Chave do comprador. Utilzada para identificar um comprador no gateway
  attr_accessor :BuyerKey

  # Dados de servi�o do antifraude
  attr_accessor :AntiFraudAnalysisData

  def initialize
    @CreditCardTransactionDataCollection = Array.new
    @BoletoTransactionDataCollection = Array.new
    @OrderData = SaleOrderData.new
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
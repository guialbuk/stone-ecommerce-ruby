class BoletoTransactionResult
  # Url para visualização do boleto
  attr_accessor :BoletoUrl

  # Código de barras
  attr_accessor :Barcode

  # Status do boleto
  attr_accessor :BoletoTransactionStatus

  # Chave da transação. Utilizada para identificar a transação de boleto no gateway
  attr_accessor :TransactionKey

  # Valor original da transação em centavos
  attr_accessor :AmountInCents

  # Número do documento
  attr_accessor :DocumentNumber

  # Identificador da transação no sistema da loja
  attr_accessor :TransactionReference

  # Indica se houve sucesso na geração do boleto
  attr_accessor :Success

  # Número de identificação do boleto
  attr_accessor :NossoNumero

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
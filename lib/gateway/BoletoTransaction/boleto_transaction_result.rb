class BoletoTransactionResult
  # Url para visualiza��o do boleto
  attr_accessor :BoletoUrl

  # C�digo de barras
  attr_accessor :Barcode

  # Status do boleto
  attr_accessor :BoletoTransactionStatus

  # Chave da transa��o. Utilizada para identificar a transa��o de boleto no gateway
  attr_accessor :TransactionKey

  # Valor original da transa��o em centavos
  attr_accessor :AmountInCents

  # N�mero do documento
  attr_accessor :DocumentNumber

  # Identificador da transa��o no sistema da loja
  attr_accessor :TransactionReference

  # Indica se houve sucesso na gera��o do boleto
  attr_accessor :Success

  # N�mero de identifica��o do boleto
  attr_accessor :NossoNumero

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
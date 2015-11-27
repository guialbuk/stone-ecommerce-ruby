class BoletoTransactionData
  # Url para visualiza��o do boleto
  attr_accessor :BoletoUrl

  # C�digo de barras do boleto
  attr_accessor :Barcode

  # Status do boleto
  attr_accessor :BoletoTransactionStatus

  # Chave da transa��o. Utilizada para identificar a transa��o de boleto no gateway
  attr_accessor :TransactionKey

  # Valor original do boleto em centavos
  attr_accessor :AmountInCents

  # N�mero do documento
  attr_accessor :DocumentNumber

  # Identificador da transa��o no sistema da loja
  attr_accessor :TransactionReference

  # Data de expira��o do boleto
  attr_accessor :ExpirationDate

  # N�mero do banco
  attr_accessor :BankNumber

  # Valor total pago em centavos
  attr_accessor :AmountPaidInCents

  # Data de cria��o do boleto no gateway
  attr_accessor :CreateDate

  # Identificador do boleto
  attr_accessor :NossoNumero

  def to_json
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
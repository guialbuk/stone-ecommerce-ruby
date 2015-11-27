require_relative '../../gateway/InstantBuy/credit_card_data'
class CreditCardTransactionData
  # Dados do cart�o de cr�dito
  attr_accessor :CreditCard

  # Status da transa��o de cart�o de cr�dito
  attr_accessor :CreditCardTransactionStatus

  @@CreditCardTransactionStatusEnum = {
      :AuthorizedPendingCapture => '1',
      :NotAuthorized => '2',
      :ChargebackPreview => '3',
      :RefundPreview => '4',
      :DepositPreview => '5',
      :Captured => '6',
      :PartialCapture => '7',
      :Refunded => '8',
      :Voided => '9',
      :Deposited => '10',
      :Chargeback => '12',
      :PendingVoid => '13',
      :Invalid => '14',
      :PartialAlthorize => '15',
      :PartialRefunded => '16',
      :OverCapture => '17',
      :PartialVoid => '18',
      :PendingRefund => '19',
      :UnScheduled => '20',
      :Created => '21',
      :PartialAuthorized => '22',
      :NotFoundInAcquirer => '23',
      :PendingAuthorize => '24',
      :WithError => '99'
  }

  # Chave da transa��o. Utilizada para identificar a transa��o de cart�o de cr�dito no gateway
  attr_accessor :TransactionKey

  # Identificador da transa��o gerado pela loja.
  attr_accessor :TransactionIdentifier

  # C�digo de autoriza��o retornado pela adquirente
  attr_accessor :AcquirerAuthorizationCode

  # Identificador �nico retornado pela adquirente
  attr_accessor :UniqueSequentialNumber

  # Valor original da transa��o em centavos
  attr_accessor :AmountInCents

  # Valor autorizado em centavos
  attr_accessor :AuthorizedAmountInCents

  # Valor capturado em centavos
  attr_accessor :CapturedAmountInCents

  # Valor estornado em centavos
  attr_accessor :RefundedAmountInCents

  # Valor cancelado em centavos
  attr_accessor :VoidedAmountInCents

  # Data da recorr�ncia (poder� ser futura)
  attr_accessor :DueDate

  # Identificador da transa��o no sistema da loja
  attr_accessor :TransactionReference

  # Data de cria��o da transa��o no gatewaya
  attr_accessor :CreateDate

  # Nome da adquirente que processou a transa��o
  attr_accessor :AcquirerName

  # Indica se � uma recorr�ncia
  attr_accessor :IsRecurrency

  # Total de parcelas na transa��o
  attr_accessor :InstallmentCount

  # C�digo de filia��o da loja na adquirente
  attr_accessor :AffiliationCode

  # C�digo do m�todo de pagamento
  attr_accessor :PaymentMethodName

  # Chave da transa��o na adquirente, enviada pelo gateway
  attr_accessor :TransactionKeyToAcquirer

  # Data limite para a captura da transa��o na adquirente
  attr_accessor :CaptureExpirationDate

  def initialize
    @CreditCard = CreditCardData.new
    @CreditCardTransactionStatus = self.CreditCardTransactionStatusEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
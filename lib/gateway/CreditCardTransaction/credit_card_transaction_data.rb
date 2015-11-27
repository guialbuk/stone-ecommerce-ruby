require_relative '../../gateway/InstantBuy/credit_card_data'
class CreditCardTransactionData
  # Dados do cartão de crédito
  attr_accessor :CreditCard

  # Status da transação de cartão de crédito
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

  # Chave da transação. Utilizada para identificar a transação de cartão de crédito no gateway
  attr_accessor :TransactionKey

  # Identificador da transação gerado pela loja.
  attr_accessor :TransactionIdentifier

  # Código de autorização retornado pela adquirente
  attr_accessor :AcquirerAuthorizationCode

  # Identificador único retornado pela adquirente
  attr_accessor :UniqueSequentialNumber

  # Valor original da transação em centavos
  attr_accessor :AmountInCents

  # Valor autorizado em centavos
  attr_accessor :AuthorizedAmountInCents

  # Valor capturado em centavos
  attr_accessor :CapturedAmountInCents

  # Valor estornado em centavos
  attr_accessor :RefundedAmountInCents

  # Valor cancelado em centavos
  attr_accessor :VoidedAmountInCents

  # Data da recorrência (poderá ser futura)
  attr_accessor :DueDate

  # Identificador da transação no sistema da loja
  attr_accessor :TransactionReference

  # Data de criação da transação no gatewaya
  attr_accessor :CreateDate

  # Nome da adquirente que processou a transação
  attr_accessor :AcquirerName

  # Indica se é uma recorrência
  attr_accessor :IsRecurrency

  # Total de parcelas na transação
  attr_accessor :InstallmentCount

  # Código de filiação da loja na adquirente
  attr_accessor :AffiliationCode

  # Código do método de pagamento
  attr_accessor :PaymentMethodName

  # Chave da transação na adquirente, enviada pelo gateway
  attr_accessor :TransactionKeyToAcquirer

  # Data limite para a captura da transação na adquirente
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
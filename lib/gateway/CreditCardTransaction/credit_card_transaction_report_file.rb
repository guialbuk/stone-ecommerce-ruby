module Gateway

  class CreditCardTransactionReportFile
    attr_accessor :Order
    attr_accessor :TransactionKey
    attr_accessor :TransactionKeyToAcquirer
    attr_accessor :CreditCardTransactionReference
    attr_accessor :CreditCardBrand
    attr_accessor :CreditCardNumber
    attr_accessor :InstallmentCount
    attr_accessor :AcquirerName
    attr_accessor :Status
    attr_accessor :AmountInCents
    attr_accessor :IataAmountInCents
    attr_accessor :AuthorizationCode
    attr_accessor :TransactionIdentifier
    attr_accessor :UniqueSequentialNumber
    attr_accessor :AuthorizedAmountInCents
    attr_accessor :CapturedAmountInCents
    attr_accessor :VoidedAmountInCents
    attr_accessor :RefundedAmountInCents
    attr_accessor :AcquirerAuthorizationReturnCode
    attr_accessor :AuthorizedDate
    attr_accessor :CapturedDate
    attr_accessor :VoidedDate
    attr_accessor :LastProbeDate

    def initialize
      @Order = OrderTransactionReportFile.new
    end
  end
end
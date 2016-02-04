module Gateway

  class OnlineDebitTransactionReportFile
    attr_accessor :Order
    attr_accessor :TransactionKey
    attr_accessor :TransactionReference
    attr_accessor :Bank
    attr_accessor :Status
    attr_accessor :AmountInCents
    attr_accessor :AmountPaidInCents
    attr_accessor :PaymentDate
    attr_accessor :BankReturnCode
    attr_accessor :BankPaymentDate
    attr_accessor :Signature
    attr_accessor :TransactionKeyToBank

    def initialize
      @Order = OrderTransactionReportFile.new
    end
  end
end

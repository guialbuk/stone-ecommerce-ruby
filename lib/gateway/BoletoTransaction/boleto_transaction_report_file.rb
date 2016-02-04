module Gateway

  class BoletoTransactionReportFile
    attr_accessor :Order
    attr_accessor :TransactionKey
    attr_accessor :TransactionReference
    attr_accessor :Status
    attr_accessor :NossoNumero
    attr_accessor :BankNumber
    attr_accessor :Agency
    attr_accessor :Account
    attr_accessor :BarCode
    attr_accessor :ExpirationDate
    attr_accessor :AmountInCents
    attr_accessor :AmountPaidInCents
    attr_accessor :PaymentDate
    attr_accessor :CreditDate

    def initialize
      @Order = OrderTransactionReportFile.new
    end
  end
end
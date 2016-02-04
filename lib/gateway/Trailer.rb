module Gateway

  class Trailer
    attr_accessor :OrderDataCount
    attr_accessor :CreditCardTransactionDataCount
    attr_accessor :BoletoTransactionDataCount
    attr_accessor :OnlineDebitTransactionDataCount
  end
end
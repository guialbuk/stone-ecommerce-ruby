module Gateway

  class CreditCardTransaction

    attr_accessor :CreditCard

    attr_accessor :Options

    attr_accessor :Recurrency

    attr_accessor :AmountInCents

    attr_accessor :InstallmentCount

    attr_accessor :CreditCardOperation

    attr_accessor :TransactionReference

    attr_accessor :TransactionDateInMerchant


    def initialize
      @Options = CreditCardTransactionOptions.new
      @Recurrency = Recurrency.new
      @CreditCard = CreditCard.new
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
module Gateway
  
  class ManageSaleRequest

    attr_accessor :CreditCardTransactionCollection

    attr_accessor :OrderKey

    def initialize
      @CreditCardTransactionCollection = Array.new;
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
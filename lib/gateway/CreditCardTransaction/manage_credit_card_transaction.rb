module Gateway

# classe para usar nos metodos de cancel e capture
  class ManageCreditCardTransaction
    attr_accessor :AmountInCents
    attr_accessor :TransactionKey
    attr_accessor :TransactionReference

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
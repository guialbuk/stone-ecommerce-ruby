module Gateway

  class RetrySaleCreditCardTransaction

    attr_accessor :TransactionKey

    attr_accessor :SecurityCode

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
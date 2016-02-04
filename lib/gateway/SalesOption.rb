module Gateway

  class SalesOption

    attr_accessor :IsAntiFraudEnabled

    attr_accessor :AntiFraudServiceCode

    attr_accessor :Retries

    attr_accessor :CurrencyIso

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
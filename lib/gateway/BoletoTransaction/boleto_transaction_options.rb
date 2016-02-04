module Gateway

  class BoletoTransactionOptions
    # Total de dias para expirar o boleto
    attr_accessor :DaysToAddInBoletoExpirationDate

    # Moeda. Opções: BRL, EUR, USD, ARS, BOB, CLP, COP, UYU, MXN, PYG
    attr_accessor :CurrencyIso

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

  end
end
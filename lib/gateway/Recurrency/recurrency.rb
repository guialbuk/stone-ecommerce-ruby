module Gateway

  class Recurrency
    # Frequência da recorrência
    attr_accessor :Frequency

    # Intervalo de recorrência
    attr_accessor :Interval

    # Data da primeira cobrança
    attr_accessor :DateToStartBilling

    # Total de recorrências
    attr_accessor :Recurrences

    # Informa se será necessário efetuar o procedimento OneDollarAuth antes de registrar a recorrência
    attr_accessor :OneDollarAuth

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
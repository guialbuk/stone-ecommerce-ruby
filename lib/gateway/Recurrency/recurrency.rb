module Gateway

  class Recurrency
    # Frequ�ncia da recorr�ncia
    attr_accessor :Frequency

    # Intervalo de recorr�ncia
    attr_accessor :Interval

    # Data da primeira cobran�a
    attr_accessor :DateToStartBilling

    # Total de recorr�ncias
    attr_accessor :Recurrences

    # Informa se ser� necess�rio efetuar o procedimento OneDollarAuth antes de registrar a recorr�ncia
    attr_accessor :OneDollarAuth

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
class GetInstantBuyDataResponse
  # Lista de cart�es de cr�dito
  attr_accessor :CreditCardDataCollection

  # Total de cart�es de cr�dito retornados
  attr_accessor :CreditCardDataCount

  def initialize
    @CreditCardDataCollection = Array.new
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
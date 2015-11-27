class RetrySaleResponse
  attr_accessor :CreditCardTransactionResultCollection

  def initialize
    @CreditCardTransactionResultCollection = Array.new
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
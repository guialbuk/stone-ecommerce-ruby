class CreditCardData
  # N�mero mascardo do cart�o de cr�dito
  attr_accessor :MaskedCreditCardNumber

  # Bandeira do cart�o de cr�dito
  attr_accessor :CreditCardBrand

  @@CreditCardBrandEnum = {
      :Visa => '1',
      :MasterCard => '2',
      :HiperCard => '3',
      :Amex => '4',
      :Diners => '5',
      :Elo => '6',
      :Aura => '7',
      :Discover => '8',
      :CasaShow => '9',
      :Havan => '10',
      :HugCard => '11',
      :AndarAki => '12',
      :LeaderCard => '13',
      :Submarino => '14'
  }

  # Chave do cart�o de cr�dito. Utilizada para identificar um cart�o de cr�dito no gateway
  attr_accessor :InstantBuyerKey

  # Informa se o cart�o de cr�dito expirou
  attr_accessor :IsExpiredCreditCard

  def initialize
    @CreditCardBrand = self.CreditCardBrandEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
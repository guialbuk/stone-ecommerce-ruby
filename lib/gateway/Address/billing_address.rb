module Gateway

  class BillingAddress
    # País. Opções: Brazil, USA, Argentina, Bolivia, Chile, Colombia, Uruguay, Mexico, Paraguay
    attr_accessor :Country

    # Estado
    attr_accessor :State

    # Cidade
    attr_accessor :City

    # Distrito
    attr_accessor :District

    # Logradouro
    attr_accessor :Street

    # Número
    attr_accessor :Number

    # Complemento
    attr_accessor :Complement

    # CEP
    attr_accessor :ZipCode

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
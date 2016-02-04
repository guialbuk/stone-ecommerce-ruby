module Gateway

  class Person
    # Nome da pessoa
    attr_accessor :Name

    # Define se é pessoa física ou jurídica
    attr_accessor :PersonType

    # Número do documento
    attr_accessor :DocumentNumber

    # Tipo de documento
    attr_accessor :DocumentType

    # Sexo da pessoa
    attr_accessor :Gender

    # Data de nascimento
    attr_accessor :Birthdate

    # E-mail
    attr_accessor :Email

    # Tipo do email. Pessoal ou comercial
    attr_accessor :EmailType

    # Código identificador do cadastro no Facebook
    attr_accessor :FacebookId

    # Código identificador do cadastro no Twitter
    attr_accessor :TwitterId

    # Telefone celular
    attr_accessor :MobilePhone

    # Telefone Residencial
    attr_accessor :HomePhone

    # Telefone comercial
    attr_accessor :WorkPhone

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
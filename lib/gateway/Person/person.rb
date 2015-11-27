class Person
  # Nome da pessoa
  attr_accessor :Name

  # Define se � pessoa f�sica ou jur�dica
  attr_accessor :PersonType

  # N�mero do documento
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

  # C�digo identificador do cadastro no Facebook
  attr_accessor :FacebookId

  # C�digo identificador do cadastro no Twitter
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
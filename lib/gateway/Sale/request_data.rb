module Gateway

  class RequestData
    # Identificador da origem de venda na loja
    attr_accessor :Origin

    # Identificador da sessão do usuário no sistema da loja (utilizado pelo serviço de antifraude)
    attr_accessor :SessionId

    # Endereço IP do cliente da loja
    attr_accessor :IpAddress

    # Categoria da venda e-commerce. B2B ou B2C
    attr_accessor :EcommerceCategory

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
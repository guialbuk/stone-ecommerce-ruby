require_relative 'person'
module Gateway

  class Buyer < Person
    # Chave do comprador. Utilizada para identificar um comprador no gateway
    attr_accessor :BuyerKey

    # Referência do comprador no sistema da loja
    attr_accessor :BuyerReference

    # Lista de endereços do comprador
    attr_accessor :AddressCollection

    # Data de criação do comprador no sistema da loja
    attr_accessor :CreateDateInMerchant

    # Data da última atualização do cadastro do comprador no sistema da loja
    attr_accessor :LastBuyerUpdateInMerchant

    # Categoria do comprador
    attr_accessor :BuyerCategory

    def initialize
      @AddressCollection = Array.new
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
module Gateway

  class Merchant
    # Identificador da loja na plataforma
    attr_accessor :MerchantReference

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
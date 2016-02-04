module Gateway

  class QuerySaleRequest
    attr_accessor :OrderKey

    attr_accessor :OrderReference

    attr_accessor :CreditCardTransactionKey

    attr_accessor :CreditCardTransactionReference

    attr_accessor :BoletoTransactionKey

    attr_accessor :BoletoTransactionReference

    attr_accessor :QuerySaleRequestEnum

    # Enum feito para as chamadas do método query
    @@QuerySaleRequestEnum = {
        :OrderKey => 'OrderKey',
        :OrderReference => 'OrderReference',
        :CreditCardTransactionKey => 'CreditCardTransactionKey',
        :CreditCardTransactionReference => 'CreditCardTransactionReference',
        :BoletoTransactionKey => 'BoletoTransactionKey',
        :BoletoTransactionReference => 'BoletoTransactionReference'
    }

    def self.QuerySaleRequestEnum
      @@QuerySaleRequestEnum
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
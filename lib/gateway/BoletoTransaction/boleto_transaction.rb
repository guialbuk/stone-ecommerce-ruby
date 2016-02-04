require 'json'
module Gateway

  class BoletoTransaction

    # Valor do boleto em centavos
    attr_accessor :AmountInCents

    # Número do banco
    attr_accessor :BankNumber

    # Instruções a serem impressas no boleto
    attr_accessor :Instructions

    # Número do documento
    attr_accessor :DocumentNumber

    # Indentificador da transação no sistema da loja
    attr_accessor :TransactionReference

    # Data da criação da transação no sistema da loja
    attr_accessor :TransactionDateInMerchant

    # Opções da transação de boleto
    attr_accessor :Options

    # Endereço de cobrança
    attr_accessor :BillingAddress

    def initialize
      @Options = BoletoTransactionOptions.new
      @BillingAddress = BillingAddress.new
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
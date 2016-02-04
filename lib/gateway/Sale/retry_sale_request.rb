require_relative 'retry_sale_options'
module Gateway

  class RetrySaleRequest

    attr_accessor :Options

    attr_accessor :OrderKey

    attr_accessor :RetrySaleCreditCardTransactionCollection

    def initialize
      @RetrySaleCreditCardTransactionCollection = Array.new
      @Options = RetrySaleOptions.new
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end

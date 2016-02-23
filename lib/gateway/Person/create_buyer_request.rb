module Gateway
  class CreateBuyerRequest < Person
    attr_accessor :AddressCollection

    attr_accessor :BuyerCategory

    attr_accessor :BuyerReference

    attr_accessor :CreateDateInMerchant

    attr_accessor :LastBuyerUpdateInMerchant

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
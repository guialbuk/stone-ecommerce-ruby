module Gateway

  class ShoppingCartCollection

    attr_accessor :FreighCostInCents

    attr_accessor :EstimatedDeliveryDate

    attr_accessor :DeliveryDeadline

    attr_accessor :ShippingCompany

    attr_accessor :DeliveryAddress

    attr_accessor :ShoppingCartItemCollection

    def initialize
      @ShoppingCartItemCollection = Array.new
      @DeliveryAddress = DeliveryAddress.new
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
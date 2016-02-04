module Gateway

  class ShoppingCartItemCollection

    attr_accessor :ItemReference

    attr_accessor :Quantity

    attr_accessor :UnitCostInCents

    attr_accessor :TotalCostInCents

    attr_accessor :Name

    attr_accessor :Description

    attr_accessor :DiscountAmountInCents

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
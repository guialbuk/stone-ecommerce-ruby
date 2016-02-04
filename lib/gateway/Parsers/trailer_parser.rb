module Gateway
  class TrailerParser
    def Parse(elements)
      if elements.length < 5
        throw('The expected parameter count is 5')
      end

      trailer = Trailer.new
      trailer.OrderDataCount = elements[1]
      trailer.CreditCardTransactionDataCount = elements[2]
      trailer.BoletoTransactionDataCount = elements[3]
      trailer.OnlineDebitTransactionDataCount = elements[4].chomp

      return trailer
    end
  end
end
module Gateway

  class BoletoTransactionParser
    def Parse(elements)
      @@DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

      if elements.length < 18
        throw('The expected parameter count is 18')
      end

      boleto_transaction = BoletoTransactionReportFile.new
      boleto_transaction.Order.OrderKey = elements[1]
      boleto_transaction.Order.OrderReference = elements[2]
      boleto_transaction.Order.MerchantKey = elements[3]
      boleto_transaction.Order.MerchantName = elements[4]

      boleto_transaction.TransactionKey = elements[5]
      boleto_transaction.TransactionReference = elements[6]
      boleto_transaction.Status = elements[7]
      boleto_transaction.NossoNumero = elements[8]
      boleto_transaction.BankNumber = elements[9]
      boleto_transaction.Agency = elements[10]
      boleto_transaction.Account = elements[11]
      boleto_transaction.BarCode = elements[12]
      boleto_transaction.ExpirationDate = DateTime.strptime(elements[13], '%m/%d/%Y %H:%M:%S').strftime(@@DATETIME_FORMAT)
      boleto_transaction.AmountInCents = elements[14].to_i
      boleto_transaction.AmountPaidInCents = (elements[15].to_s == '') == false ? elements[15].to_i : 0
      boleto_transaction.PaymentDate = (elements[16].to_s == '') == false ? DateTime.strptime(elements[16], '%m/%d/%Y %H:%M:%S').strftime(@@DATETIME_FORMAT) : nil
      boleto_transaction.CreditDate = (elements[17].chomp.to_s == '') == false ? DateTime.strptime(elements[17], '%m/%d/%Y %H:%M:%S').strftime(@@DATETIME_FORMAT) : nil

      return boleto_transaction
    end
  end
end
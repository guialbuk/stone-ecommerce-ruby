module Gateway

  class OnlineDebitTransactionParser
    def Parse(elements)
      @@DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

      if elements.length < 16
        throw('The expected parameter count is 16')
      end

      online_debit_transaction = OnlineDebitTransactionReportFile.new

      online_debit_transaction.Order.OrderKey = elements[1]
      online_debit_transaction.Order.OrderReference = elements[2]
      online_debit_transaction.Order.MerchantKey = elements[3]
      online_debit_transaction.Order.MerchantName = elements[4]

      online_debit_transaction.TransactionKey = elements[5]
      online_debit_transaction.TransactionReference = elements[6]
      online_debit_transaction.Bank = elements[7]
      online_debit_transaction.Status = elements[8]
      online_debit_transaction.AmountInCents = elements[9].to_i
      online_debit_transaction.AmountPaidInCents = (elements[10].to_s == '') == false ? elements[10].to_i : 0
      online_debit_transaction.PaymentDate = (elements[11].to_s == '') == false ? DateTime.strptime(elements[11], '%m/%d/%Y %H:%M:%S').strftime(@@DATETIME_FORMAT) : nil
      online_debit_transaction.BankReturnCode = elements[12]
      online_debit_transaction.BankPaymentDate = elements[13]
      online_debit_transaction.Signature = elements[14]
      online_debit_transaction.TransactionKeyToBank = elements[15].chomp

      return online_debit_transaction
    end
  end
end
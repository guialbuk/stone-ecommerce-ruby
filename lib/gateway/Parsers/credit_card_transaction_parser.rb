module Gateway

  class CreditCardTransactionParser
    def Parse(elements)
      @@DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

      if elements.length < 27
        throw('The expected parameter count is 27')
      end

      credit_card_transaction = CreditCardTransactionReportFile.new
      credit_card_transaction.Order.OrderKey = elements[1]
      credit_card_transaction.Order.OrderReference = elements[2]
      credit_card_transaction.Order.MerchantKey = elements[3]
      credit_card_transaction.Order.MerchantName = elements[4]

      credit_card_transaction.TransactionKey = elements[5]
      credit_card_transaction.TransactionKeyToAcquirer = elements[6]
      credit_card_transaction.CreditCardTransactionReference = elements[7]
      credit_card_transaction.CreditCardBrand = elements[8]
      credit_card_transaction.CreditCardNumber = elements[9]
      credit_card_transaction.InstallmentCount = (elements[10].to_s == '') == false ? elements[10].to_i : 0
      credit_card_transaction.AcquirerName = elements[11]
      credit_card_transaction.Status = elements[12]
      credit_card_transaction.AmountInCents = (elements[13].to_s == '') == false ? elements[13].to_i : 0
      credit_card_transaction.IataAmountInCents = (elements[14].to_s == '') == false ? elements[14].to_i : 0
      credit_card_transaction.AuthorizationCode = elements[15]
      credit_card_transaction.TransactionIdentifier = elements[16]
      credit_card_transaction.UniqueSequentialNumber = elements[17]
      credit_card_transaction.AuthorizedAmountInCents = (elements[18].to_s == '') == false ? elements[18].to_i : 0
      credit_card_transaction.CapturedAmountInCents = (elements[19].to_s == '') == false ? elements[19].to_i : 0
      credit_card_transaction.VoidedAmountInCents = (elements[20].to_s == '') == false ? elements[20].to_i : 0
      credit_card_transaction.RefundedAmountInCents = (elements[21].to_s == '') == false ? elements[21].to_i : 0
      credit_card_transaction.AcquirerAuthorizationReturnCode = elements[22]
      credit_card_transaction.AuthorizedDate = (elements[23].to_s == '') == false ? DateTime.strptime(elements[23], '%Y-%m-%dT%H:%M:%S').strftime(@@DATETIME_FORMAT) : nil
      credit_card_transaction.CapturedDate = (elements[24].to_s == '') == false ? DateTime.strptime(elements[24], '%Y-%m-%dT%H:%M:%S').strftime(@@DATETIME_FORMAT) : nil
      credit_card_transaction.VoidedDate = (elements[25].to_s == '') == false ? DateTime.strptime(elements[25], '%Y-%m-%dT%H:%M:%S').strftime(@@DATETIME_FORMAT) : nil
      credit_card_transaction.LastProbeDate = (elements[26].chomp.to_s == '') == false ? DateTime.strptime(elements[26], '%Y-%m-%dT%H:%M:%S').strftime(@@DATETIME_FORMAT) : nil

      return credit_card_transaction
    end
  end
end
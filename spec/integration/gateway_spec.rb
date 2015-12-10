require_relative '../../lib/stone_ecommerce'
require_relative 'test_helper'

merchant_key = 'merchant_key'
gateway = Gateway.new(:production, merchant_key)

RSpec.describe Gateway do
  it 'should create a sale with boleto' do
    createSaleRequest = CreateSaleRequest.new

    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    response = gateway.CreateSale(createSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should create a sale with credit card' do
    createSaleRequest = CreateSaleRequest.new

    buyerAddress = BuyerAddress.new
    buyerAddress.AddressType = 'Residential'
    buyerAddress.City = 'Rio de Janeiro'
    buyerAddress.Complement = '10 Andar'
    buyerAddress.Country = 'Brazil'
    buyerAddress.District = 'Centro'
    buyerAddress.Number = '199'
    buyerAddress.State = 'RJ'
    buyerAddress.Street = 'Rua da Quitanda'
    buyerAddress.ZipCode = '20091005'

    creditCardTransaction = CreditCardTransaction.new
    creditCardTransaction.AmountInCents = 100
    creditCardTransaction.InstallmentCount = 1
    creditCardTransaction.TransactionReference = 'CreditCard One RubySDK Test'
    creditCardTransaction.Options.PaymentMethodCode = 1
    creditCardTransaction.Options.SoftDescriptorText = 'My Store Name'
    creditCardTransaction.CreditCard.CreditCardNumber = '5453010000066167'
    creditCardTransaction.CreditCard.ExpMonth = 5
    creditCardTransaction.CreditCard.ExpYear = 18
    creditCardTransaction.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransaction.CreditCard.SecurityCode = '123'
    creditCardTransaction.CreditCard.CreditCardBrand = 'Mastercard'
    creditCardTransaction.CreditCard.BillingAddress.City = 'Rio de Janeiro'
    creditCardTransaction.CreditCard.BillingAddress.Complement = '10 Andar'
    creditCardTransaction.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransaction.CreditCard.BillingAddress.District = 'Centro'
    creditCardTransaction.CreditCard.BillingAddress.Number = '199'
    creditCardTransaction.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransaction.CreditCard.BillingAddress.Street = 'Rua da Quitanda'
    creditCardTransaction.CreditCard.BillingAddress.ZipCode = '20091005'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    createSaleRequest.Buyer.Birthdate = Date.new(2001, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.BuyerCategory = 'Normal'
    createSaleRequest.Buyer.Email = 'mundiBuyer@mundi.com.br'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '22222222'
    createSaleRequest.Buyer.MobilePhone = '988888888'
    createSaleRequest.Buyer.WorkPhone = '25555555'
    createSaleRequest.Buyer.CreateDateInMerchant = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.LastBuyerUpdateInMerchant = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.DocumentNumber = '51212382749'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Name = 'Jose da Silva Ramos'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.AddressCollection << buyerAddress

    response = gateway.CreateSale(createSaleRequest)

    expect(response[:ErrorReport]).to eq nil

  end

  it 'should create a sale with all types of transactions and all fields filled' do
    buyerAddressItem = BuyerAddress.new
    buyerAddressItem.AddressType = 'Comercial'
    buyerAddressItem.City = 'Rio de Janeiro'
    buyerAddressItem.Complement = '10 Andar'
    buyerAddressItem.Country = 'Brazil'
    buyerAddressItem.District = 'Centro'
    buyerAddressItem.Number = '199'
    buyerAddressItem.State = 'RJ'
    buyerAddressItem.Street = 'Rua da Quitanda'
    buyerAddressItem.ZipCode = '20091005'

    boletoTransactionItem = BoletoTransaction.new
    boletoTransactionItem.AmountInCents = 350
    boletoTransactionItem.BankNumber = '237'
    boletoTransactionItem.BillingAddress.City = 'Rio de Janeiro'
    boletoTransactionItem.BillingAddress.Complement = '10º andar'
    boletoTransactionItem.BillingAddress.Country = 'Brazil'
    boletoTransactionItem.BillingAddress.District = 'Centro'
    boletoTransactionItem.BillingAddress.Number = '199'
    boletoTransactionItem.BillingAddress.State = 'RJ'
    boletoTransactionItem.BillingAddress.Street = 'Rua da Quitanda'
    boletoTransactionItem.BillingAddress.ZipCode = '20091005'
    boletoTransactionItem.DocumentNumber = '12345678901'
    boletoTransactionItem.Instructions = 'Pagar antes do vencimento'
    boletoTransactionItem.Options.CurrencyIso = 'BRL'
    boletoTransactionItem.Options.DaysToAddInBoletoExpirationDate = 7
    boletoTransactionItem.TransactionDateInMerchant = Date.new(2014, 11, 5).strftime("%Y-%m-%dT%H:%M:%S")
    boletoTransactionItem.TransactionReference = 'RubySDK-BoletoTransactionTest'

    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 750
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.TransactionDateInMerchant = Date.new(2014, 11, 5).strftime("%Y-%m-%dT%H:%M:%S")
    creditCardTransactionItem.TransactionReference = 'RubySDK-CreditCardTransactionTest'
    creditCardTransactionItem.Options.CaptureDelayInMinutes = 0
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.ExtendedLimitCode = nil
    creditCardTransactionItem.Options.ExtendedLimitEnabled = false
    creditCardTransactionItem.Options.IataAmountInCents = 0
    creditCardTransactionItem.Options.InterestRate = 0
    creditCardTransactionItem.Options.MerchantCategoryCode = nil
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.Options.SoftDescriptorText = 'Nome da Loja'
    creditCardTransactionItem.Recurrency.DateToStartBilling = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    creditCardTransactionItem.Recurrency.Frequency = 'Monthly'
    creditCardTransactionItem.Recurrency.Interval = 1
    creditCardTransactionItem.Recurrency.OneDollarAuth = false
    creditCardTransactionItem.Recurrency.Recurrences = 2
    creditCardTransactionItem.CreditCard.BillingAddress.City = 'Rio de Janeiro'
    creditCardTransactionItem.CreditCard.BillingAddress.Complement = '10º andar'
    creditCardTransactionItem.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransactionItem.CreditCard.BillingAddress.District = 'Centro'
    creditCardTransactionItem.CreditCard.BillingAddress.Number = '199'
    creditCardTransactionItem.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransactionItem.CreditCard.BillingAddress.Street = 'Ruda da Quitanda'
    creditCardTransactionItem.CreditCard.BillingAddress.ZipCode = '20091005'
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.InstantBuyKey = '00000000-0000-0000-0000-000000000000'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'

    shoppingCartItem = ShoppingCartItemCollection.new
    shoppingCartItem.Description = 'Descricao do Produto'
    shoppingCartItem.DiscountAmountInCents = 120
    shoppingCartItem.ItemReference = 'product#666'
    shoppingCartItem.Name = 'Nome do produto'
    shoppingCartItem.Quantity = 1
    shoppingCartItem.TotalCostInCents = 1100
    shoppingCartItem.UnitCostInCents = 1220

    shoppingCartCollectionItem = ShoppingCartCollection.new
    shoppingCartCollectionItem.DeliveryAddress.City = 'Rio de Janeiro'
    shoppingCartCollectionItem.DeliveryAddress.Complement = '10º andar'
    shoppingCartCollectionItem.DeliveryAddress.Country = 'Brazil'
    shoppingCartCollectionItem.DeliveryAddress.District = 'Centro'
    shoppingCartCollectionItem.DeliveryAddress.Number = '199'
    shoppingCartCollectionItem.DeliveryAddress.State = 'RJ'
    shoppingCartCollectionItem.DeliveryAddress.Street = 'Rua da Quitanda'
    shoppingCartCollectionItem.DeliveryAddress.ZipCode = '20091005'
    shoppingCartCollectionItem.DeliveryDeadline = Date.new(2014, 12, 5).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollectionItem.EstimatedDeliveryDate = Date.new(2014, 11, 25).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollectionItem.FreighCostInCents = 0
    shoppingCartCollectionItem.ShippingCompany = 'Nome da empresa responsável pela entrega'
    shoppingCartCollectionItem.ShoppingCartItemCollection << shoppingCartItem

    createSaleRequest = CreateSaleRequest.new

    createSaleRequest.Buyer.AddressCollection = Array.new

    createSaleRequest.Buyer.Birthdate = Date.new(1990, 3, 3).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.DocumentNumber = '12345678901'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Email = 'someone@example.com'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.FacebookId = ''
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '2112345678'
    createSaleRequest.Buyer.MobilePhone = '21987654321'
    createSaleRequest.Buyer.Name = 'Someone'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.TwitterId = ''
    createSaleRequest.Buyer.WorkPhone = '2178563412'
    createSaleRequest.Buyer.BuyerCategory = 'Normal'
    createSaleRequest.Buyer.BuyerKey = '00000000-0000-0000-0000-000000000000'
    createSaleRequest.Buyer.BuyerReference = 'RubyBuyer#JohnConnor'
    createSaleRequest.Buyer.CreateDateInMerchant = Date.new(2014, 4, 15).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.LastBuyerUpdateInMerchant = Date.new(2014, 4, 15).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.AddressCollection << buyerAddressItem
    createSaleRequest.Merchant.MerchantReference = 'Nome da Loja'
    createSaleRequest.Options.AntiFraudServiceCode = 0
    createSaleRequest.Options.CurrencyIso = 'BRL'
    createSaleRequest.Options.IsAntiFraudEnabled = false
    createSaleRequest.Options.Retries = 3
    createSaleRequest.Order.OrderReference = 'RubySDK-TestOrder'
    createSaleRequest.RequestData.EcommerceCategory = 'B2B'
    createSaleRequest.RequestData.IpAddress = '127.0.0.1'
    createSaleRequest.RequestData.Origin = ''
    createSaleRequest.RequestData.SessionId = ''
    createSaleRequest.BoletoTransactionCollection << boletoTransactionItem
    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem

    response = gateway.CreateSale(createSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should consult the order with order key' do
    querySaleRequest = QuerySaleRequest.new
    createSaleRequest = CreateSaleRequest.new

    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    boleto_response = gateway.CreateSale(createSaleRequest)

    querySaleRequest.OrderKey = boleto_response['OrderResult']['OrderKey']
    responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)

    orderKey = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderKey"]

    expect(orderKey).to eq querySaleRequest.OrderKey
  end

  it 'should consult the order with order reference' do
    querySaleRequest = QuerySaleRequest.new
    createSaleRequest = CreateSaleRequest.new

    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

    createSaleRequest.Order.OrderReference = 'RubyOrderReferenceUnitTest'
    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    boleto_response = gateway.CreateSale(createSaleRequest)

    querySaleRequest.OrderReference = boleto_response['OrderResult']['OrderReference']
    responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)

    orderReference = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderReference"]

    expect(orderReference).to eq querySaleRequest.OrderReference
  end

  it 'should do a retry method' do
    retrySaleRequest = RetrySaleRequest.new
    retrySaleCreditCardTransactionItem = RetrySaleCreditCardTransaction.new

    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-RetryTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-RetryTest'

    # cria o pedido que sera usado para retentativa
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer a retentativa
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # monta o objeto de retentativa
    retrySaleCreditCardTransactionItem.SecurityCode = '123'
    retrySaleCreditCardTransactionItem.TransactionKey = transactionKey
    retrySaleRequest.OrderKey = orderKey
    retrySaleRequest.RetrySaleCreditCardTransactionCollection << retrySaleCreditCardTransactionItem

    # faz a requisicao de retentativa
    response = gateway.Retry(retrySaleRequest)

    # espera que o transaction key seja igual, significa que foi tudo ok no teste
    responseTransactionKey = response['CreditCardTransactionResultCollection'][0]['TransactionKey']

    expect(responseTransactionKey).to eq transactionKey

  end

  it 'should do a retry method with only order key' do
    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 22
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.TransactionReference = 'RubySDK-RetryTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-RetryTest'

    # cria o pedido que sera usado para retentativa
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer a retentativa
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    retrySaleRequest = RetrySaleRequest.new

    # monta o objeto de retentativa
    retrySaleRequest.OrderKey = orderKey

    # faz a requisicao de retentativa
    response = gateway.Retry(retrySaleRequest)

    expect(response['ErrorReport']).to eq nil

  end

  it 'should cancel a transaction' do
    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-CancelTest'

    # cria o pedido que sera usado para cancelamento
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer o cancelamento
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # itens necessarios para cancelamento da transacao de cartao de credito
    cancelCreditCardTransactionItem = ManageCreditCardTransaction.new
    cancelCreditCardTransactionItem.AmountInCents = 100
    cancelCreditCardTransactionItem.TransactionKey = transactionKey
    cancelCreditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

    # monta o objeto para cancelamento de transacao
    cancelSaleRequest = ManageSaleRequest.new
    cancelSaleRequest.OrderKey = orderKey
    cancelSaleRequest.CreditCardTransactionCollection << cancelCreditCardTransactionItem

    response = gateway.Cancel(cancelSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should capture a transaction' do
    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-CaptureTest'

    # cria o pedido que sera usado para captura
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer a captura
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # itens necessarios para captura da transacao de cartao de credito
    captureCreditCardTransactionItem = ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = 100
    captureCreditCardTransactionItem.TransactionKey = transactionKey
    captureCreditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest'

    # monta o objeto para cancelamento de transacao
    captureSaleRequest = ManageSaleRequest.new
    captureSaleRequest.OrderKey = orderKey
    captureSaleRequest.CreditCardTransactionCollection << captureCreditCardTransactionItem

    response = gateway.Capture(captureSaleRequest)

    # espera que o ErrorReport seja nulo, significa que foi tudo ok na transação
    expect(response['ErrorReport']).to eq nil
  end

  it 'should do a parse xml to notification interpretation' do
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.TransactionReference = 'Ruby PostNotification Test'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransactionItem.CreditCard.HolderName = 'Bruce Wayne'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCard.ExpMonth = 5
    creditCardTransactionItem.CreditCard.ExpYear = 20
    creditCardTransactionItem.Options.PaymentMethodCode = 1

    createSaleRequest = CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem

    response_hash = gateway.CreateSale(createSaleRequest)

    credit_card_result = response_hash['CreditCardTransactionResultCollection'][0]

    expect(credit_card_result['Success']).to eq true
    # expect(credit_card_result['CreditCardOperation']).to eq 'AuthOnly'
    # expect(credit_card_result['CreditCardTransactionStatus']).to eq 'AuthorizedPendingCapture'

    captureCreditCardTransactionItem = ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = creditCardTransactionItem.AmountInCents
    captureCreditCardTransactionItem.TransactionKey = credit_card_result['TransactionKey']
    captureCreditCardTransactionItem.TransactionReference = creditCardTransactionItem.TransactionReference

    captureSale = ManageSaleRequest.new
    captureSale.OrderKey = response_hash['OrderResult']['OrderKey']
    captureSale.CreditCardTransactionCollection << captureCreditCardTransactionItem

    captureResponse = gateway.Capture(captureSale)

    expect(captureResponse['ErrorReport']).to eq nil


    xml = TestHelper.CreateFakePostNotification(response_hash, captureResponse)

    response = gateway.ParseXmlToNotification(xml)

    expect(response.nil?).to eq false
  end

  it 'should do a parse on online debit xml' do
    xml = '<StatusNotification xmlns="http://schemas.datacontract.org/2004/07/Gateway.NotificationService.DataContract"
                    xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
                    i:schemaLocation="http://schemas.datacontract.org/2004/07/Gateway.NotificationService.DataContract StatusNotificationXmlSchema.xsd">
  <AmountInCents>500</AmountInCents>
  <AmountPaidInCents>0</AmountPaidInCents>
  <BoletoTransaction>
    <AmountInCents>500</AmountInCents>
    <AmountPaidInCents>0</AmountPaidInCents>
    <BoletoExpirationDate>2013-02-08T00:00:00</BoletoExpirationDate>
    <NossoNumero>0123456789</NossoNumero>
    <StatusChangedDate>2012-11-06T08:55:49.753</StatusChangedDate>
    <TransactionKey>4111D523-9A83-4BE3-94D2-160F1BC9C4BD</TransactionKey>
    <TransactionReference>B2E32108</TransactionReference>
    <PreviousBoletoTransactionStatus>Generated</PreviousBoletoTransactionStatus>
    <BoletoTransactionStatus>Paid</BoletoTransactionStatus>
  </BoletoTransaction>
  <CreditCardTransaction>
    <Acquirer>Simulator</Acquirer>
    <AmountInCents>2000</AmountInCents>
    <AuthorizedAmountInCents>2000</AuthorizedAmountInCents>
    <CapturedAmountInCents>2000</CapturedAmountInCents>
    <CreditCardBrand>Visa</CreditCardBrand>
    <RefundedAmountInCents i:nil="true"/>
    <StatusChangedDate>2012-11-06T10:52:55.93</StatusChangedDate>
    <TransactionIdentifier>123456</TransactionIdentifier>
    <TransactionKey>351FC96A-7F42-4269-AF3C-1E3C179C1CD0</TransactionKey>
    <TransactionReference>24de0432</TransactionReference>
    <UniqueSequentialNumber>123456</UniqueSequentialNumber>
    <VoidedAmountInCents i:nil="true"/>
    <PreviousCreditCardTransactionStatus>AuthorizedPendingCapture</PreviousCreditCardTransactionStatus>
    <CreditCardTransactionStatus>Captured</CreditCardTransactionStatus>
  </CreditCardTransaction>

  <OnlineDebitTransaction>
    <AmountInCents>100</AmountInCents>
    <AmountPaidInCents>0</AmountPaidInCents>
    <StatusChangedDate>2013-06-27T19:46:46.87</StatusChangedDate>
    <TransactionKey>fb3f158a-0309-4ae3-b8ef-3c5ac2d603d2</TransactionKey>
    <TransactionReference>30bfee13-c908-4e3b-9f70-1f84dbe79fbf</TransactionReference>
    <PreviousOnlineDebitTransactionStatus>OpenedPendingPayment</PreviousOnlineDebitTransactionStatus>
    <OnlineDebitTransactionStatus>NotPaid</OnlineDebitTransactionStatus>
  </OnlineDebitTransaction>

  <MerchantKey>B1B1092C-8681-40C2-A734-500F22683D9B</MerchantKey>
  <OrderKey>18471F05-9F6D-4497-9C24-D60D5BBB6BBE</OrderKey>
  <OrderReference>64a85875</OrderReference>
  <OrderStatus>Paid</OrderStatus>
</StatusNotification>'

    response = gateway.ParseXmlToNotification(xml)

    expect(response.nil?).to eq false
  end

  # it 'should bring the transaction report file' do
  #   date = Date.new(2015, 9, 19)
  #   result = gateway.TransactionReportFile(date)
  #   split_commas = result.split(',')
  #
  #   expect(split_commas[1]).to eq '20150919'
  # end
  #
  # it 'should parse the transaction report file received' do
  #   date = Date.new(2015, 9, 19)
  #   request_to_parse = gateway.TransactionReportFile(date)
  #   result = gateway.TransactionReportFileParser(request_to_parse)
  #
  #   expect(result['Header'].TransactionProcessedDate).to eq '20150919'
  # end
  #
  # it 'should save the transaction report file at selected path' do
  #   date = Date.new(2015, 9, 19)
  #
  #   file = Tempfile.new('Test')
  #   gateway.TransactionReportFileDownloader(date, 'Test', file.path)
  #
  #   file_path = file.path.to_s + 'Test.txt'
  #   file_exist = File.exist?(file_path)
  #
  #   file.close
  #   file.unlink
  #
  #   expect(file_exist).to eq true
  # end

  it 'should consult transaction with instant buy key' do
    credit_card_transaction = CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    response = gateway.InstantBuyKey(instant_buy_key)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should consult transaction with buyer key' do

    credit_card_transaction = CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = CreateSaleRequest.new
    sale_request.Buyer.Name = 'Anakin Skywalker'
    sale_request.Buyer.Birthdate = Date.new(1994, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    sale_request.Buyer.DocumentNumber = '12345678901'
    sale_request.Buyer.DocumentType = 'CPF'
    sale_request.Buyer.PersonType = 'Person'
    sale_request.Buyer.Gender = 'M'
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    response = gateway.BuyerKey(sale_response['BuyerKey'])

    expect(response['ErrorReport']).to eq nil
  end

  it 'should do a credit card transaction with instant buy key' do
    credit_card_transaction = CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    # coleta dados do cartao
    creditCardTransaction = CreditCardTransaction.new
    creditCardTransaction.AmountInCents = 100
    creditCardTransaction.CreditCard.InstantBuyKey = instant_buy_key

    # cria a transacao
    createSaleRequest = CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction

    # faz a requisicao de criação de transacao, retorna um hash com a resposta
    response = gateway.CreateSale(createSaleRequest)

    expect(response['ErrorReport']).to eq nil
  end

end

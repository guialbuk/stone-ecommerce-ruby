require_relative '../../lib/stone_ecommerce'
require_relative 'test_helper'

merchant_key = 'merchant_key'

gateway = Gateway::Gateway.new(:production, merchant_key)

RSpec.describe Gateway do
  it 'should create a sale with boleto' do
    createSaleRequest = Gateway::CreateSaleRequest.new

    boletoTransaction = Gateway::BoletoTransaction.new
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
    createSaleRequest = Gateway::CreateSaleRequest.new

    buyerAddress = Gateway::BuyerAddress.new
    buyerAddress.AddressType = 'Residential'
    buyerAddress.City = 'Rio de Janeiro'
    buyerAddress.Complement = '10 Andar'
    buyerAddress.Country = 'Brazil'
    buyerAddress.District = 'Centro'
    buyerAddress.Number = '199'
    buyerAddress.State = 'RJ'
    buyerAddress.Street = 'Rua da Quitanda'
    buyerAddress.ZipCode = '20091005'

    creditCardTransaction = Gateway::CreditCardTransaction.new
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
    # creates boleto transaction object
    boletoTransaction = Gateway::BoletoTransaction.new

    # 100 reais in cents
    boletoTransaction.AmountInCents = 10000
    boletoTransaction.BankNumber = '237'
    boletoTransaction.BillingAddress.City = 'Tatooine'
    boletoTransaction.BillingAddress.Complement = ''
    boletoTransaction.BillingAddress.Country = 'Brazil'
    boletoTransaction.BillingAddress.District = 'Mos Eisley'
    boletoTransaction.BillingAddress.Number = '123'
    boletoTransaction.BillingAddress.State = 'RJ'
    boletoTransaction.BillingAddress.Street = 'Mos Eisley Cantina'
    boletoTransaction.BillingAddress.ZipCode = '20001000'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5
    boletoTransaction.TransactionReference = 'NumeroDaTransacao'


    # create credit card transaction object
    creditCardTransaction = Gateway::CreditCardTransaction.new

    # 100 reais in cents
    creditCardTransaction.AmountInCents = 10000
    creditCardTransaction.CreditCard.BillingAddress.City = 'Tatooine'
    creditCardTransaction.CreditCard.BillingAddress.Complement = ''
    creditCardTransaction.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransaction.CreditCard.BillingAddress.District = 'Mos Eisley'
    creditCardTransaction.CreditCard.BillingAddress.Number = '123'
    creditCardTransaction.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransaction.CreditCard.BillingAddress.Street = 'Mos Eisley Cantina'
    creditCardTransaction.CreditCard.BillingAddress.ZipCode = '20001000'
    creditCardTransaction.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransaction.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransaction.CreditCard.ExpMonth = 10
    creditCardTransaction.CreditCard.ExpYear = 22
    creditCardTransaction.CreditCard.HolderName = 'LUKE SKYWALKER'
    creditCardTransaction.CreditCard.SecurityCode = '123'
    creditCardTransaction.CreditCardOperation = 'AuthOnly'
    creditCardTransaction.InstallmentCount = 1
    creditCardTransaction.Options.CurrencyIso = 'BRL'
    creditCardTransaction.Options.PaymentMethodCode = 1
    creditCardTransaction.Options.SoftDescriptorText = 'Jedi Mega Store'

    shoppingCartItem = Gateway::ShoppingCartItemCollection.new
    shoppingCartItem.Description = 'Red Lightsaber'
    shoppingCartItem.DiscountAmountInCents = 0
    shoppingCartItem.ItemReference = 'NumeroDoProduto'
    shoppingCartItem.Name = 'Lightsaber'
    shoppingCartItem.Quantity = 1
    shoppingCartItem.TotalCostInCents = 18000
    shoppingCartItem.UnitCostInCents = 18000

    shoppingCartCollection = Gateway::ShoppingCartCollection.new
    shoppingCartCollection.DeliveryAddress.City = 'Galaxy far far away'
    shoppingCartCollection.DeliveryAddress.Complement = 'Bridge'
    shoppingCartCollection.DeliveryAddress.Country = 'Brazil'
    shoppingCartCollection.DeliveryAddress.District = 'Command Room'
    shoppingCartCollection.DeliveryAddress.Number = '321'
    shoppingCartCollection.DeliveryAddress.State = 'RJ'
    shoppingCartCollection.DeliveryAddress.Street = 'Death Star'
    shoppingCartCollection.DeliveryAddress.ZipCode = '10002000'
    shoppingCartCollection.DeliveryDeadline = DateTime.new(2015, 12, 14, 18, 36, 45).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollection.EstimatedDeliveryDate = DateTime.new(2015, 12, 14, 18, 36, 45).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollection.FreighCostInCents = 2000
    shoppingCartCollection.ShippingCompany = 'Empire'
    shoppingCartCollection.ShoppingCartItemCollection << shoppingCartItem

    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new

    # adds to the boleto transaction collection
    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    buyerAddress = Gateway::BuyerAddress.new
    buyerAddress.AddressType = 'Residential'
    buyerAddress.City = 'Tatooine'
    buyerAddress.Complement = ''
    buyerAddress.Country = 'Brazil'
    buyerAddress.District = 'Mos Eisley'
    buyerAddress.Number = '123'
    buyerAddress.State = 'RJ'
    buyerAddress.Street = 'Mos Eisley Cantina'
    buyerAddress.ZipCode = '20001000'

    createSaleRequest.Buyer.AddressCollection << buyerAddress
    createSaleRequest.Buyer.Birthdate = DateTime.new(1990,8,20,0,0,0).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.BuyerCategory = 'Normal'
    createSaleRequest.Buyer.BuyerReference = 'C3PO'
    createSaleRequest.Buyer.CreateDateInMerchant = DateTime.new(2015,12,11,18,36,45).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.DocumentNumber = '12345678901'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Email = 'lskywalker@r2d2.com'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.FacebookId = 'lukeskywalker8917'
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '(21)123456789'
    createSaleRequest.Buyer.MobilePhone = '(21)987654321'
    createSaleRequest.Buyer.Name = 'Luke Skywalker'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.TwitterId = '@lukeskywalker8917'
    createSaleRequest.Buyer.WorkPhone = '(21)28467902'

    # adds to the credit card transaction collection
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    createSaleRequest.Merchant.MerchantReference = 'IdDaLojaPlataforma'
    createSaleRequest.Options.AntiFraudServiceCode = 0
    createSaleRequest.Options.CurrencyIso = 'BRL'
    createSaleRequest.Options.IsAntiFraudEnabled = true
    createSaleRequest.Options.Retries = 1
    createSaleRequest.Order.OrderReference = 'NumeroDoPedido'
    createSaleRequest.RequestData.EcommerceCategory = 'B2C'
    createSaleRequest.RequestData.IpAddress = '127.0.0.1'
    createSaleRequest.RequestData.Origin = 'SiteDeCompra'
    createSaleRequest.RequestData.SessionId = 'IdSesssaoNoSite'

    # adds shopping cart collection in the request
    createSaleRequest.ShoppingCartCollection << shoppingCartCollection

    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should create an anti fraud transaction' do
    # create credit card transaction object
    creditCardTransaction = Gateway::CreditCardTransaction.new

    # 100 reais in cents
    creditCardTransaction.AmountInCents = 10000
    creditCardTransaction.CreditCard.BillingAddress.City = 'Tatooine'
    creditCardTransaction.CreditCard.BillingAddress.Complement = ''
    creditCardTransaction.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransaction.CreditCard.BillingAddress.District = 'Mos Eisley'
    creditCardTransaction.CreditCard.BillingAddress.Number = '123'
    creditCardTransaction.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransaction.CreditCard.BillingAddress.Street = 'Mos Eisley Cantina'
    creditCardTransaction.CreditCard.BillingAddress.ZipCode = '20001000'
    creditCardTransaction.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransaction.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransaction.CreditCard.ExpMonth = 10
    creditCardTransaction.CreditCard.ExpYear = 22
    creditCardTransaction.CreditCard.HolderName = 'LUKE SKYWALKER'
    creditCardTransaction.CreditCard.SecurityCode = '123'
    creditCardTransaction.InstallmentCount = 1

    shoppingCartItem = Gateway::ShoppingCartItemCollection.new
    shoppingCartItem.Description = 'Red Lightsaber'
    shoppingCartItem.DiscountAmountInCents = 0
    shoppingCartItem.ItemReference = 'NumeroDoProduto'
    shoppingCartItem.Name = 'Lightsaber'
    shoppingCartItem.Quantity = 1
    shoppingCartItem.TotalCostInCents = 18000
    shoppingCartItem.UnitCostInCents = 0

    shoppingCartCollection = Gateway::ShoppingCartCollection.new
    shoppingCartCollection.DeliveryAddress.City = 'Galaxy far far away'
    shoppingCartCollection.DeliveryAddress.Complement = 'Bridge'
    shoppingCartCollection.DeliveryAddress.Country = 'Brazil'
    shoppingCartCollection.DeliveryAddress.District = 'Command Room'
    shoppingCartCollection.DeliveryAddress.Number = '321'
    shoppingCartCollection.DeliveryAddress.State = 'RJ'
    shoppingCartCollection.DeliveryAddress.Street = 'Death Star'
    shoppingCartCollection.DeliveryAddress.ZipCode = '10002000'
    shoppingCartCollection.FreighCostInCents = 2000
    shoppingCartCollection.ShoppingCartItemCollection << shoppingCartItem

    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new

    buyerAddress = Gateway::BuyerAddress.new
    buyerAddress.AddressType = 'Residential'
    buyerAddress.City = 'Tatooine'
    buyerAddress.Complement = ''
    buyerAddress.Country = 'Brazil'
    buyerAddress.District = 'Mos Eisley'
    buyerAddress.Number = '123'
    buyerAddress.State = 'RJ'
    buyerAddress.Street = 'Mos Eisley Cantina'
    buyerAddress.ZipCode = '20001000'

    createSaleRequest.Buyer.AddressCollection << buyerAddress
    createSaleRequest.Buyer.Birthdate = DateTime.new(1990,8,20,0,0,0).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.BuyerReference = 'C3PO'
    createSaleRequest.Buyer.DocumentNumber = '12345678901'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Email = 'lskywalker@r2d2.com'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '(21)123456789'
    createSaleRequest.Buyer.MobilePhone = '(21)987654321'
    createSaleRequest.Buyer.Name = 'Luke Skywalker'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.WorkPhone = '(21)28467902'

    # adds to the credit card transaction collection
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    createSaleRequest.Options.IsAntiFraudEnabled = true
    createSaleRequest.Order.OrderReference = 'NumeroDoPedido'

    # adds shopping cart collection in the request
    createSaleRequest.ShoppingCartCollection << shoppingCartCollection

    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should consult the order with order key' do
    querySaleRequest = Gateway::QuerySaleRequest.new
    createSaleRequest = Gateway::CreateSaleRequest.new

    boletoTransaction = Gateway::BoletoTransaction.new
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
    responseQuery = gateway.Query(Gateway::QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)

    orderKey = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderKey"]

    expect(orderKey).to eq querySaleRequest.OrderKey
  end

  it 'should consult the order with order reference' do
    querySaleRequest = Gateway::QuerySaleRequest.new
    createSaleRequest = Gateway::CreateSaleRequest.new

    boletoTransaction = Gateway::BoletoTransaction.new
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
    responseQuery = gateway.Query(Gateway::QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)

    orderReference = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderReference"]

    expect(orderReference).to eq querySaleRequest.OrderReference
  end

  it 'should do a retry method' do
    retrySaleRequest = Gateway::RetrySaleRequest.new
    retrySaleCreditCardTransactionItem = Gateway::RetrySaleCreditCardTransaction.new

    createSaleRequest = Gateway::CreateSaleRequest.new
    creditCardTransactionItem = Gateway::CreditCardTransaction.new
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
    createSaleRequest = Gateway::CreateSaleRequest.new
    creditCardTransactionItem = Gateway::CreditCardTransaction.new
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

    retrySaleRequest = Gateway::RetrySaleRequest.new

    # monta o objeto de retentativa
    retrySaleRequest.OrderKey = orderKey

    # faz a requisicao de retentativa
    response = gateway.Retry(retrySaleRequest)

    expect(response['ErrorReport']).to eq nil

  end

  it 'should cancel a transaction' do
    createSaleRequest = Gateway::CreateSaleRequest.new
    creditCardTransactionItem = Gateway::CreditCardTransaction.new
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
    cancelCreditCardTransactionItem = Gateway::ManageCreditCardTransaction.new
    cancelCreditCardTransactionItem.AmountInCents = 100
    cancelCreditCardTransactionItem.TransactionKey = transactionKey
    cancelCreditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

    # monta o objeto para cancelamento de transacao
    cancelSaleRequest = Gateway::ManageSaleRequest.new
    cancelSaleRequest.OrderKey = orderKey
    cancelSaleRequest.CreditCardTransactionCollection << cancelCreditCardTransactionItem

    response = gateway.Cancel(cancelSaleRequest)

    expect(response[:ErrorReport]).to eq nil
  end

  it 'should capture a transaction' do
    createSaleRequest = Gateway::CreateSaleRequest.new
    creditCardTransactionItem = Gateway::CreditCardTransaction.new
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
    captureCreditCardTransactionItem = Gateway::ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = 100
    captureCreditCardTransactionItem.TransactionKey = transactionKey
    captureCreditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest'

    # monta o objeto para cancelamento de transacao
    captureSaleRequest = Gateway::ManageSaleRequest.new
    captureSaleRequest.OrderKey = orderKey
    captureSaleRequest.CreditCardTransactionCollection << captureCreditCardTransactionItem

    response = gateway.Capture(captureSaleRequest)

    # espera que o ErrorReport seja nulo, significa que foi tudo ok na transação
    expect(response['ErrorReport']).to eq nil
  end

  it 'should do a parse xml to notification interpretation' do
    creditCardTransactionItem = Gateway::CreditCardTransaction.new
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

    createSaleRequest = Gateway::CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem

    response_hash = gateway.CreateSale(createSaleRequest)

    credit_card_result = response_hash['CreditCardTransactionResultCollection'][0]

    expect(credit_card_result['Success']).to eq true
    # expect(credit_card_result['CreditCardOperation']).to eq 'AuthOnly'
    # expect(credit_card_result['CreditCardTransactionStatus']).to eq 'AuthorizedPendingCapture'

    captureCreditCardTransactionItem = Gateway::ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = creditCardTransactionItem.AmountInCents
    captureCreditCardTransactionItem.TransactionKey = credit_card_result['TransactionKey']
    captureCreditCardTransactionItem.TransactionReference = creditCardTransactionItem.TransactionReference

    captureSale = Gateway::ManageSaleRequest.new
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

=begin
  it 'should bring the transaction report file' do
    date = Date.new(2015, 9, 19)
    result = gateway.TransactionReportFile(date)
    split_commas = result.split(',')

    expect(split_commas[1]).to eq '20150919'
  end

  it 'should parse the transaction report file received' do
    date = Date.new(2015, 9, 19)
    request_to_parse = gateway.TransactionReportFile(date)
    result = gateway.TransactionReportFileParser(request_to_parse)

    expect(result['Header'].TransactionProcessedDate).to eq '20150919'
  end

  it 'should save the transaction report file at selected path' do
    date = Date.new(2015, 9, 19)

    file = Tempfile.new('Test')
    gateway.TransactionReportFileDownloader(date, 'Test', file.path)

    file_path = file.path.to_s + 'Test.txt'
    file_exist = File.exist?(file_path)

    file.close
    file.unlink

    expect(file_exist).to eq true
  end
=end

  it 'should get credit card instant buy key deprecated' do
    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    response = gateway.InstantBuyKey(instant_buy_key)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should get credit card instant buy key' do
    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    response = gateway.GetCreditCard(instant_buy_key)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should delete credit card instant buy key' do
    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    response = gateway.DeleteCreditCard(instant_buy_key)

    expect(response['Success']).to eq true
  end

  it 'should consult get credit card with buyer key deprecated' do

    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
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

  it 'should consult get credit card with buyer key' do

    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.Buyer.Name = 'Anakin Skywalker'
    sale_request.Buyer.Birthdate = Date.new(1994, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    sale_request.Buyer.DocumentNumber = '12345678901'
    sale_request.Buyer.DocumentType = 'CPF'
    sale_request.Buyer.PersonType = 'Person'
    sale_request.Buyer.Gender = 'M'
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    response = gateway.GetCreditCardWithBuyerKey(sale_response['BuyerKey'])

    expect(response['ErrorReport']).to eq nil
  end

  it 'should create a credit card' do
    create_instant_buy_data = Gateway::CreateInstantBuyData.new
    create_instant_buy_data.CreditCardNumber = '4111111111111111'
    create_instant_buy_data.ExpMonth = 10
    create_instant_buy_data.ExpYear = 2018
    create_instant_buy_data.SecurityCode = '123'
    create_instant_buy_data.HolderName = 'Luke Skywalker'
    create_instant_buy_data.CreditCardBrand = 'Visa'
    create_instant_buy_data.IsOneDollarAuthEnabled = true
    create_instant_buy_data.BillingAddress.City = 'Rio de Janeiro'
    create_instant_buy_data.BillingAddress.Complement = 'Em frente ao Aeroporto'
    create_instant_buy_data.BillingAddress.Country = 'Brazil'
    create_instant_buy_data.BillingAddress.District = 'Centro'
    create_instant_buy_data.BillingAddress.Number = '123'
    create_instant_buy_data.BillingAddress.State = 'RJ'
    create_instant_buy_data.BillingAddress.Street = 'Av. General Justo'
    create_instant_buy_data.BillingAddress.ZipCode = '20270004'

    response = gateway.CreateCreditCard(create_instant_buy_data)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should create a credit card without billing address' do
    create_instant_buy_data = Gateway::CreateInstantBuyData.new
    create_instant_buy_data.CreditCardNumber = '4111111111111111'
    create_instant_buy_data.ExpMonth = 10
    create_instant_buy_data.ExpYear = 2018
    create_instant_buy_data.SecurityCode = '123'
    create_instant_buy_data.HolderName = 'Luke Skywalker'
    create_instant_buy_data.CreditCardBrand = 'Visa'

    response = gateway.CreateCreditCard(create_instant_buy_data)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should update the credit card' do
    create_instant_buy_data = Gateway::CreateInstantBuyData.new
    create_instant_buy_data.CreditCardNumber = '4111111111111111'
    create_instant_buy_data.ExpMonth = 10
    create_instant_buy_data.ExpYear = 2018
    create_instant_buy_data.SecurityCode = '123'
    create_instant_buy_data.HolderName = 'Luke Skywalker'
    create_instant_buy_data.CreditCardBrand = 'Visa'
    create_instant_buy_data.IsOneDollarAuthEnabled = true
    create_instant_buy_data.BillingAddress.City = 'Rio de Janeiro'
    create_instant_buy_data.BillingAddress.Complement = 'Em frente ao Aeroporto'
    create_instant_buy_data.BillingAddress.Country = 'Brazil'
    create_instant_buy_data.BillingAddress.District = 'Centro'
    create_instant_buy_data.BillingAddress.Number = '123'
    create_instant_buy_data.BillingAddress.State = 'RJ'
    create_instant_buy_data.BillingAddress.Street = 'Av. General Justo'
    create_instant_buy_data.BillingAddress.ZipCode = '20270004'

    create_credit_card = gateway.CreateCreditCard(create_instant_buy_data)

    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.Buyer.Name = 'Anakin Skywalker'
    sale_request.Buyer.Birthdate = Date.new(1994, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    sale_request.Buyer.DocumentNumber = '12345678901'
    sale_request.Buyer.DocumentType = 'CPF'
    sale_request.Buyer.PersonType = 'Person'
    sale_request.Buyer.Gender = 'M'
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    instant_buy_key = create_credit_card['InstantBuyKey']

    buyer_key = sale_response['BuyerKey']

    response = gateway.UpdateCreditCard(instant_buy_key, buyer_key)

    expect(response['Success']).to eq true
  end

  it 'should do a credit card transaction with instant buy key' do
    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    instant_buy_key = sale_response['CreditCardTransactionResultCollection'][0]['CreditCard']['InstantBuyKey']

    # coleta dados do cartao
    creditCardTransaction = Gateway::CreditCardTransaction.new
    creditCardTransaction.AmountInCents = 100
    creditCardTransaction.CreditCard.InstantBuyKey = instant_buy_key

    # cria a transacao
    createSaleRequest = Gateway::CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction

    # faz a requisicao de criação de transacao, retorna um hash com a resposta
    response = gateway.CreateSale(createSaleRequest)

    expect(response['ErrorReport']).to eq nil
  end

  it 'should get the buyer with buyer key' do
    credit_card_transaction = Gateway::CreditCardTransaction.new
    credit_card_transaction.CreditCard.CreditCardNumber = '4111111111111111'
    credit_card_transaction.CreditCard.CreditCardBrand = 'Visa'
    credit_card_transaction.CreditCard.ExpMonth = 10
    credit_card_transaction.CreditCard.ExpYear = 2018
    credit_card_transaction.CreditCard.SecurityCode = '123'
    credit_card_transaction.CreditCard.HolderName = 'Luke Skywalker'
    credit_card_transaction.AmountInCents = 100

    sale_request = Gateway::CreateSaleRequest.new
    sale_request.Buyer.Name = 'Anakin Skywalker'
    sale_request.Buyer.Birthdate = Date.new(1994, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    sale_request.Buyer.DocumentNumber = '12345678901'
    sale_request.Buyer.DocumentType = 'CPF'
    sale_request.Buyer.PersonType = 'Person'
    sale_request.Buyer.Gender = 'M'
    sale_request.CreditCardTransactionCollection << credit_card_transaction

    sale_response = gateway.CreateSale(sale_request)

    expect(sale_response['ErrorReport']).to eq nil

    response = gateway.GetBuyer(sale_response['BuyerKey'])

    expect(response['ErrorReport']).to eq nil
  end

  it 'should create buyer with buyer request' do
    address = Gateway::BuyerAddress.new
    address.AddressType = 'Residential'
    address.City = 'Tatooine'
    address.Complement = ''
    address.Country = 'Brazil'
    address.District = 'Mos Eisley'
    address.Number = '123'
    address.State = 'RJ'
    address.Street = 'Mos Eisley Cantina'
    address.ZipCode = '20001000'

    buyer_request = Gateway::BuyerRequest.new
    buyer_request.AddressCollection << address
    buyer_request.Birthdate = DateTime.new(1990,8,20,0,0,0).strftime("%Y-%m-%dT%H:%M:%S")
    buyer_request.BuyerCategory = 'Normal'
    buyer_request.BuyerReference = 'C3PO'
    buyer_request.CreateDateInMerchant = DateTime.new(2015,12,11,18,36,45).strftime("%Y-%m-%dT%H:%M:%S")
    buyer_request.DocumentNumber = '12345678901'
    buyer_request.DocumentType = 'CPF'
    buyer_request.Email = 'lskywalker@r2d2.com'
    buyer_request.EmailType = 'Personal'
    buyer_request.FacebookId = 'lukeskywalker8917'
    buyer_request.Gender = 'M'
    buyer_request.HomePhone = '(21)123456789'
    buyer_request.IpAddress = '192.168.1.1'
    buyer_request.LastBuyerUpdateInMerchant = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
    buyer_request.MobilePhone = '(21)987654321'
    buyer_request.Name = 'Luke Skywalker'
    buyer_request.PersonType = 'Person'
    buyer_request.TwitterId = '@lukeskywalker8917'
    buyer_request.WorkPhone = '(21)28467902'

    response = gateway.CreateBuyer(buyer_request)

    expect(response['Success']).to eq true
  end
end

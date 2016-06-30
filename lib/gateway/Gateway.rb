require_relative '../../lib/stone_ecommerce'
module Gateway

  class Gateway
    extend Gem::Deprecate

    attr_reader :service_environment

    attr_reader :merchant_key

    # URL de producao
    @@SERVICE_URL_PRODUCTION = 'https://transaction.stone.com.br'

    # URL de homologacao
    @@SERVICE_URL_STAGING = ''

    # URL de sandbox
    @@SERVICE_URL_SANDBOX = 'https://transaction.stone.com.br'

    # URL do postnotification de producao
    @@SERVICE_URL_REPORT_FILE_PRODUCTION = ''

    # URL do postnotification de sandbox
    @@SERVICE_URL_REPORT_FILE_SANDBOX = ''

    # Service Url
    @@SERVICE_URL = ''

    # Service Url Notification
    @@SERVICE_URL_REPORT_FILE = ''

    def initialize(environment=:sandbox, merchant_key)
      @service_environment = environment

      if @service_environment == :staging
        @@SERVICE_URL = @@SERVICE_URL_STAGING
        @@SERVICE_URL_REPORT_FILE = @@SERVICE_URL_REPORT_FILE_PRODUCTION

        # se for producao, faz a chamada por aqui
      elsif @service_environment == :production
        @@SERVICE_URL = @@SERVICE_URL_PRODUCTION
        @@SERVICE_URL_REPORT_FILE = @@SERVICE_URL_REPORT_FILE_PRODUCTION

        # se for sandbox
      elsif @service_environment == :sandbox
        @@SERVICE_URL = @@SERVICE_URL_SANDBOX
        @@SERVICE_URL_REPORT_FILE = @@SERVICE_URL_REPORT_FILE_SANDBOX
      end

      @merchant_key = merchant_key
      @@SERVICE_HEADERS = {:MerchantKey => "#{@merchant_key}", :Accept => 'application/json', :"Content-Type" => 'application/json'}
    end

    def self.new_with_urls (environment_url=@@SERVICE_URL_SANDBOX, report_file_url=@@SERVICE_URL_REPORT_FILE_SANDBOX, merchant_key)
      @@SERVICE_URL = environment_url
      @@SERVICE_URL_REPORT_FILE = report_file_url
      self.new(nil, merchant_key)
    end

    # permite que o integrador adicione uma busca por transacoes utilizando alguns criterios
    def Query(querySaleRequestEnum, key)
      # try, tenta fazer o request
      begin
        getRequest(@@SERVICE_URL + '/Sale/Query/' + querySaleRequestEnum + '=' + key)

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
    end

    # criar uma transacao na plataforma One utilizando um ou mais meios de pagamento
    def CreateSale(createSaleRequest)

      saleHash = createSaleRequest.to_json

      saleHash['BoletoTransactionCollection'] = []

      saleHash['CreditCardTransactionCollection'] = []

      saleHash['ShoppingCartCollection'] = []

      begin
        # transforma a colecao de boleto em json
        if createSaleRequest.BoletoTransactionCollection.any? == false || createSaleRequest.BoletoTransactionCollection.nil?
          saleHash['BoletoTransactionCollection'] = nil

        else
          createSaleRequest.BoletoTransactionCollection.each_with_index do |boleto, index|
            b = boleto.to_json
            saleHash['BoletoTransactionCollection'] << b

            if boleto.Options.to_json.any?
              boleto_options = boleto.Options.to_json
              saleHash['BoletoTransactionCollection'][index]['Options'] = boleto_options
            else
              saleHash['BoletoTransactionCollection'][index]['Options'] = nil
            end

            if boleto.BillingAddress.to_json.any?
              boleto_billing_address = boleto.BillingAddress.to_json
              saleHash['BoletoTransactionCollection'][index]['BillingAddress'] = boleto_billing_address
            else
              saleHash['BoletoTransactionCollection'][index]['BillingAddress'] = nil
            end
          end
        end

        # transforma a colecao de cartao de credito em json
        if createSaleRequest.CreditCardTransactionCollection.any? == false || createSaleRequest.CreditCardTransactionCollection.nil?
          saleHash['CreditCardTransactionCollection'] = nil
        else
          createSaleRequest.CreditCardTransactionCollection.each_with_index do |creditCard, index|
            c = creditCard.to_json
            saleHash['CreditCardTransactionCollection'] << c

            if creditCard.Options.to_json.any?
              credit_card_options = creditCard.Options.to_json
              saleHash['CreditCardTransactionCollection'][index]['Options'] = credit_card_options
            else
              saleHash['CreditCardTransactionCollection'][index]['Options'] = nil
            end

            if creditCard.Recurrency.to_json.any?
              credit_card_recurrency = creditCard.Recurrency.to_json
              saleHash['CreditCardTransactionCollection'][index]['Recurrency'] = credit_card_recurrency
            else
              saleHash['CreditCardTransactionCollection'][index]['Recurrency'] = nil
            end

            if creditCard.CreditCard.to_json.any?
              credit_card_item = creditCard.CreditCard.to_json
              saleHash['CreditCardTransactionCollection'][index]['CreditCard'] = credit_card_item

              if creditCard.CreditCard.BillingAddress.to_json.any?
                credit_card_billing_address = creditCard.CreditCard.BillingAddress.to_json
                saleHash['CreditCardTransactionCollection'][index]['CreditCard']['BillingAddress'] = credit_card_billing_address
              else
                saleHash['CreditCardTransactionCollection'][index]['CreditCard']['BillingAddress'] = nil
              end

            else
              saleHash['CreditCardTransactionCollection'][index]['CreditCard'] = nil
            end
          end
        end

        # transforma a colecao de shoppingcart em json
        if createSaleRequest.ShoppingCartCollection.any? == false || createSaleRequest.ShoppingCartCollection.nil?
          saleHash['ShoppingCartCollection'] = nil
        else
          createSaleRequest.ShoppingCartCollection.each_with_index do |shoppingCart, index|
            s = shoppingCart.to_json
            saleHash['ShoppingCartCollection'] << s

            if shoppingCart.DeliveryAddress.to_json.any?
              delivery_address = shoppingCart.DeliveryAddress.to_json
              saleHash['ShoppingCartCollection'][index]['DeliveryAddress'] = delivery_address
            else
              saleHash['ShoppingCartCollection'][index]['DeliveryAddress'] = nil
            end

            if shoppingCart.ShoppingCartItemCollection.any?
              shoppingCart.ShoppingCartItemCollection.each_with_index do |cartItem, cartIndex|
                item = cartItem.to_json
                saleHash['ShoppingCartCollection'][index]['ShoppingCartItemCollection'][cartIndex] = item
              end
            else
              saleHash['ShoppingCartCollection'][index]['ShoppingCartItemCollection'] = nil
            end
          end
        end

        # transforma objeto options em json
        if createSaleRequest.Options.to_json.any?
          o = createSaleRequest.Options.to_json
          saleHash['Options'] = o
        else
          saleHash['Options'] = nil
        end

        # transforma objeto order em json
        if createSaleRequest.Order.to_json.any?
          order = createSaleRequest.Order.to_json
          saleHash['Order'] = order
        else
          saleHash['Order'] = nil
        end

        # transforma objeto merchant em json
        if createSaleRequest.Merchant.to_json.any?
          merchant = createSaleRequest.Merchant.to_json
          saleHash['Merchant'] = merchant
        else
          saleHash['Merchant'] = nil
        end

        # transforma objeto request data em json
        if createSaleRequest.RequestData.to_json.any?
          request_data = createSaleRequest.RequestData.to_json
          saleHash['RequestData'] = request_data
        else
          saleHash['RequestData'] = nil
        end

        # transforma o objeto Buyer em json
        if createSaleRequest.Buyer.AddressCollection.any?
          b = createSaleRequest.Buyer.to_json
          saleHash['Buyer'] = b

          saleHash['Buyer']['AddressCollection'] = []
          createSaleRequest.Buyer.AddressCollection.each do |address|
            a = address.to_json
            saleHash['Buyer']['AddressCollection'] << a
          end
        else
          buyer_hash = createSaleRequest.Buyer.to_json
          buyer_hash.delete('AddressCollection')
          if buyer_hash.blank? == false
            b = createSaleRequest.Buyer.to_json
            saleHash['Buyer'] = b
            saleHash['Buyer']['AddressCollection'] = nil
          else
            saleHash['Buyer'] = nil
          end
        end

      rescue Exception => e
        return e.message
      end

      postRequest(saleHash.to_json, @@SERVICE_URL + '/Sale/')
    end

    # permite forcar a retentativa manualmente de uma transacao (podendo ser tambem uma recorrencia) nao autorizada
    def Retry(retrySaleRequest)
      saleHash = retrySaleRequest.to_json
      saleHash['RetrySaleCreditCardTransactionCollection'] = []

      begin
        if retrySaleRequest.RetrySaleCreditCardTransactionCollection != nil
          retrySaleRequest.RetrySaleCreditCardTransactionCollection.each do |retrySale|
            r = retrySale.to_json
            saleHash['RetrySaleCreditCardTransactionCollection'] << r
          end
        end
        if retrySaleRequest.Options.to_json.any?
          retry_options = retrySaleRequest.Options.to_json
          saleHash['Options'] = retry_options
        else
          saleHash['Options'] = nil
        end
      rescue Exception => e
        return e.message
      end

      postRequest(saleHash.to_json, @@SERVICE_URL + '/Sale/Retry')
    end

    # eh uma forma de desfazer uma transação com cartao de credito mesmo a transacao sendo capturada
    def Cancel(cancelSaleRequest)
      saleHash = cancelSaleRequest.to_json
      saleHash['CreditCardTransactionCollection'] = []

      begin
        if cancelSaleRequest.CreditCardTransactionCollection != nil
          cancelSaleRequest.CreditCardTransactionCollection.each do |creditCard|
            c = creditCard.to_json
            saleHash['CreditCardTransactionCollection'] << c
          end
        end
      rescue Exception => e
        return e.message
      end

      postRequest(saleHash.to_json, @@SERVICE_URL + '/Sale/Cancel')
    end

    # confirmacao de uma transacao de cartao de credito que ja fora autorizada
    def Capture(captureRequest)
      saleHash = captureRequest.to_json
      saleHash['CreditCardTransactionCollection'] = []

      begin
        if captureRequest.CreditCardTransactionCollection != nil
          captureRequest.CreditCardTransactionCollection.each do |creditCard|
            c = creditCard.to_json
            saleHash['CreditCardTransactionCollection'] << c
          end
        end
      rescue Exception => e
        return e.message
      end

      postRequest(saleHash.to_json, @@SERVICE_URL + '/Sale/Capture')
    end

    # faz um parse do xml de post notificaton
    def ParseXmlToNotification(xml)
      begin
        response = PostNotification.ParseNotification(xml)
      rescue Exception => err
        return err.message
      end

      return response
    end

    # faz uma requisicao e retorna uma string com o transaction report file
    def TransactionReportFile(date)
      begin
        response = getReportFile(@@SERVICE_URL_REPORT_FILE + '/TransactionReportFile/GetStream?fileDate=' + date.strftime("%Y%m%d"))
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
      return response
    end

    # faz o download do transaction report file e salva no computador em .txt
    def TransactionReportFileDownloader(date, file_name, path)
      begin
        path = path + file_name + '.txt'

        response = TransactionReportFile(date)

        File.write(path, response)
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
    end

    # faz o parse da string recebida do transaction report file e retorna um hash
    def TransactionReportFileParser(file_to_parse)
      transaction_report_file = TransactionReportFile.new
      begin
        response = transaction_report_file.TransactionReportFileParser(file_to_parse)
      rescue Exception => err
        return err
      end
      return response
    end

    # DEPRECATED
    def InstantBuyKey(instant_buy_key)
      GetCreditCard(instant_buy_key)
    end
    deprecate :InstantBuyKey, :GetCreditCard, 2016, 04

    # DEPRECATED
    def BuyerKey(buyer_key)
      GetCreditCardWithBuyerKey(buyer_key)
    end
    deprecate :BuyerKey, :GetCreditCardWithBuyerKey, 2016, 04

    # faz um get credit card com buyer key
    def GetCreditCardWithBuyerKey(buyer_key)
      # try, tenta fazer o request
      begin
        response = getRequest(@@SERVICE_URL + '/CreditCard/BuyerKey=' + buyer_key)

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end

      # se nao houver erros, retorna o objeto
      response
    end

    # Faz um get no cartão de crédito
    def GetCreditCard(instant_buy_key)
      # try, tenta fazer o request
      begin
        getRequest(@@SERVICE_URL + '/CreditCard/' + instant_buy_key)

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
    end

    # Cria um cartão de crédito
    def CreateCreditCard(create_instant_buy_data)
      sale_hash = create_instant_buy_data.to_json
      begin
        if create_instant_buy_data.BillingAddress.to_json.any?
          sale_hash['BillingAddress'] = create_instant_buy_data.BillingAddress.to_json
        else
          sale_hash['BillingAddress'] = nil
        end

        response = postRequest(sale_hash.to_json, @@SERVICE_URL + '/CreditCard/')

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
      # se nao houver erros, retorna o objeto
      response
    end

    # Atualiza o cartão de crédito
    def UpdateCreditCard(instant_buy_key, update_instant_buy_data_request)
      begin
        sale_hash = update_instant_buy_data_request.to_json

        response = patchRequest(sale_hash.to_json, @@SERVICE_URL + '/CreditCard/' + instant_buy_key)
          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
      # se nao houver erros, retorna o objeto
      response
    end

    # Deleta um cartão de crédito
    def DeleteCreditCard(instant_buy_key)
      # try, tenta fazer o request
      begin
        deleteRequest(@@SERVICE_URL + '/CreditCard/' + instant_buy_key)

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
    end

    # Busca um buyer
    def GetBuyer(buyer_key)
      # try, tenta fazer o request
      begin
        response = getRequest(@@SERVICE_URL + '/Buyer/' + buyer_key)

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end

      # se nao houver erros, retorna o objeto
      response
    end

    # Cria um buyer
    def CreateBuyer(buyer_request)
      sale_hash = buyer_request.to_json
      sale_hash['AddressCollection'] = []
      begin
        if buyer_request.AddressCollection.any? == false || buyer_request.AddressCollection.nil?
          sale_hash['AddressCollection'] = nil
        else
          buyer_request.AddressCollection.each do |address|
            a = address.to_json
            sale_hash['AddressCollection'] << a
          end
        end

        response = postRequest(sale_hash.to_json, @@SERVICE_URL + '/Buyer/')
      rescue Exception => e
        return e.message
      end
      response
    end

    # funcao de post generica
    def postRequest(payload, url)
      begin
        response = RestClient.post(url, payload, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        response = err.response
      end

      JSON.load response
    rescue JSON::ParserError => err
      response
    end

    # funcao patch generica
    def patchRequest(payload, url)
      begin
        response = RestClient.patch(url, payload, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        response = err.response
      end

      JSON.load response
    rescue JSON::ParserError => err
      response
    end

    # funcao de delete generica
    def deleteRequest(url)
      begin
        response = RestClient.delete(url, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        response = err.response
      end

      JSON.load response
    rescue JSON::ParserError => err
      response
    end

    # funcao get generica
    def getRequest(url)
      begin
        response = RestClient.get(url, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        response = err.response
      end

      JSON.load response
    rescue JSON::ParserError => err
      response
    end

    def getReportFile(url)
      begin
        response = RestClient.get(url, headers={:MerchantKey => "#{@merchant_key}"})
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
      return response
    end
  end
end

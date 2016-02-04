require_relative '../../lib/stone_ecommerce'
module Gateway

  class Gateway

    attr_reader :serviceEnvironment

    attr_reader :merchantKey

    def initialize(environment=:sandbox, merchantKey)
      @serviceEnvironment = environment
      @merchantKey = merchantKey
      @@SERVICE_HEADERS = {:MerchantKey => "#{@merchantKey}", :Accept => 'application/json', :"Content-Type" => 'application/json'}
    end

    # URL de producao
    @@SERVICE_URL_PRODUCTION = 'https://transaction.stone.com.br'

    # URL de homologacao
    @@SERVICE_URL_STAGING = ''

    # URL de sandbox
    @@SERVICE_URL_SANDBOX = 'https://transaction.stone.com.br'

    # URL do postnotification de producao
    @@SERVICE_URL_NOTIFICATION_PRODUCTION = ''

    # URL do postnotification de sandbox
    @@SERVICE_URL_NOTIFICATION_SANDBOX = ''

    # permite que o integrador adicione uma busca por transacoes utilizando alguns criterios
    def Query(querySaleRequestEnum, key)
      # try, tenta fazer o request
      begin
        # se for homologacao faz a chamada por aqui
        if @serviceEnvironment == :staging
          getRequest(@@SERVICE_URL_STAGING + '/Sale/Query/' + querySaleRequestEnum + '=' + key)

          # se for producao, faz a chamada por aqui
        elsif @serviceEnvironment == :production
          getRequest(@@SERVICE_URL_PRODUCTION + '/Sale/Query/' + querySaleRequestEnum + '=' + key)

          # se for sandbox
        elsif @serviceEnvironment == :sandbox
          getRequest(@@SERVICE_URL_SANDBOX + '/Sale/Query/' + querySaleRequestEnum + '=' + key)
        end

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

      if @serviceEnvironment == :staging
        url = @@SERVICE_URL_STAGING + '/Sale/'
      elsif @serviceEnvironment == :production
        url = @@SERVICE_URL_PRODUCTION + '/Sale/'
      elsif @serviceEnvironment == :sandbox
        url = @@SERVICE_URL_SANDBOX + '/Sale/'
      end
      postRequest(saleHash.to_json, url)
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
      if @serviceEnvironment == :staging
        url = @@SERVICE_URL_STAGING + '/Sale/Retry'
      elsif @serviceEnvironment == :production
        url = @@SERVICE_URL_PRODUCTION + '/Sale/Retry'
      elsif @serviceEnvironment == :sandbox
        url = @@SERVICE_URL_SANDBOX + '/Sale/Retry'
      end
      postRequest(saleHash.to_json, url)
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
      if @serviceEnvironment == :staging
        url = @@SERVICE_URL_STAGING + '/Sale/Cancel'
      elsif @serviceEnvironment == :production
        url = @@SERVICE_URL_PRODUCTION + '/Sale/Cancel'
      elsif @serviceEnvironment == :sandbox
        url = @@SERVICE_URL_SANDBOX + '/Sale/Cancel'
      end
      postRequest(saleHash.to_json, url)
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
      if @serviceEnvironment == :staging
        url = @@SERVICE_URL_STAGING + '/Sale/Capture'
      elsif @serviceEnvironment == :production
        url = @@SERVICE_URL_PRODUCTION + '/Sale/Capture'
      elsif @serviceEnvironment == :sandbox
        url = @@SERVICE_URL_SANDBOX + '/Sale/Capture'
      end
      postRequest(saleHash.to_json, url)
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
        if @serviceEnvironment == :staging
          url = @@SERVICE_URL_NOTIFICATION_PRODUCTION + date.strftime("%Y%m%d")
        elsif @serviceEnvironment == :production
          url = @@SERVICE_URL_NOTIFICATION_PRODUCTION + date.strftime("%Y%m%d")
        elsif @serviceEnvironment == :sandbox
          url = @@SERVICE_URL_NOTIFICATION_SANDBOX + date.strftime("%Y%m%d")
        end

        response = getReportFile(url)

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

    # faz uma requisicao com instant buy key
    def InstantBuyKey(instant_buy_key)
      # try, tenta fazer o request
      begin

        # se for homologacao faz a chamada por aqui
        if @serviceEnvironment == :staging
          getRequest(@@SERVICE_URL_STAGING + '/CreditCard/' + instant_buy_key)

          # se for producao, faz a chamada por aqui
        elsif @serviceEnvironment == :production
          getRequest(@@SERVICE_URL_PRODUCTION + '/CreditCard/' + instant_buy_key)

          # se for sandbox
        elsif @serviceEnvironment == :sandbox
          getRequest(@@SERVICE_URL_SANDBOX + '/CreditCard/' + instant_buy_key)
        end

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end
    end

    # faz uma requisicao com buyer key
    def BuyerKey(buyer_key)
      # try, tenta fazer o request
      begin

        # se for homologacao faz a chamada por aqui
        if @serviceEnvironment == :staging
          response = getRequest(@@SERVICE_URL_STAGING + '/CreditCard/' + buyer_key + '/BuyerKey')

          # se for producao, faz a chamada por aqui
        elsif @serviceEnvironment == :production
          response = getRequest(@@SERVICE_URL_PRODUCTION + '/CreditCard/' + buyer_key + '/BuyerKey')

          # se for sandbox, faz a chamada por aqui
        elsif @serviceEnvironment == :sandbox
          response = getRequest(@@SERVICE_URL_SANDBOX + '/CreditCard/' + buyer_key + '/BuyerKey')
        end

          # se der algum erro, trata aqui
      rescue Exception => e
        return e.message
      end

      # se nao houver erros, retorna o objeto
      response
    end

    # funcao de post generica
    def postRequest(payload, url)
      response = nil
      begin
        response = RestClient.post(url, payload, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
      json_response = JSON.load response
      json_response
    end

    # funcao get generica
    def getRequest(url)
      response = nil
      begin
        response = RestClient.get(url, headers=@@SERVICE_HEADERS)
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
      json_response = JSON.load response
      json_response
    end

    def getReportFile(url)
      begin
        response = RestClient.get(url, headers={:MerchantKey => "#{@merchantKey}"})
      rescue RestClient::ExceptionWithResponse => err
        return err.response
      end
      return response
    end
  end
end
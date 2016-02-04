module Gateway

  class TransactionReportFile
    def TransactionReportFileParser(file_to_parse)
      response = {}
      response['CreditCardTransaction'] = []
      response['OnlineDebitTransaction'] = []
      response['BoletoTransaction'] = []

      header_parser = HeaderParser.new
      credit_card_parser = CreditCardTransactionParser.new
      boleto_parser = BoletoTransactionParser.new
      online_debit_parser = OnlineDebitTransactionParser.new
      trailer_parser = TrailerParser.new

      begin
        response_splited = file_to_parse.split("\n")

        response_splited.each do |item|

          to_parse_item = item.split(',')
          if to_parse_item[0] == '01'
            response['Header'] = header_parser.Parse(to_parse_item)
          end

          if to_parse_item[0] == '20'
            response['CreditCardTransaction'] << credit_card_parser.Parse(to_parse_item)
          end

          if to_parse_item[0] == '40'
            response['OnlineDebitTransaction'] << online_debit_parser.Parse(to_parse_item)
          end

          if to_parse_item[0] == '30'
            response['BoletoTransaction'] << boleto_parser.Parse(to_parse_item)
          end

          if to_parse_item[0] == '99'
            response['Trailer'] = trailer_parser.Parse(to_parse_item)
          end
        end
      rescue Exception => err
        return err
      end
      return response
    end
  end
end
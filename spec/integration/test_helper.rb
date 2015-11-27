require_relative '../../lib/stone_ecommerce'
require 'gyoku'
class TestHelper

  def self.JoinAndConvertAmountAndCents(amount, cents)
    amount_with_cents = amount.gsub(',', '.')
    return BigDecimal.new(amount_with_cents)
  end

  def self.CreateFakePostNotification(create_order_result, manage_order_result)
    xml = '<StatusNotification xmlns="http://schemas.datacontract.org/2004/07/Gateway.NotificationService.DataContract"
									xmlns:i="http://www.w3.org/2001/XMLSchema-instance">
				<AmountInCents>?</AmountInCents>
				<AmountPaidInCents>?</AmountPaidInCents>
				<BoletoTransaction i:nil="true"/>
				<CreditCardTransaction>
					<Acquirer>Cielo</Acquirer>
					<AmountInCents>?</AmountInCents>
					<AuthorizedAmountInCents>?</AuthorizedAmountInCents>
					<CapturedAmountInCents>?</CapturedAmountInCents>
					<CreditCardBrand>?</CreditCardBrand>
					<RefundedAmountInCents i:nil="true"/>
					<StatusChangedDate>?</StatusChangedDate>
					<TransactionIdentifier>?</TransactionIdentifier>
					<TransactionKey>?</TransactionKey>
					<TransactionReference>?</TransactionReference>
					<UniqueSequentialNumber>?</UniqueSequentialNumber>
					<VoidedAmountInCents i:nil="true"/>
					<PreviousCreditCardTransactionStatus>?</PreviousCreditCardTransactionStatus>
					<CreditCardTransactionStatus>?</CreditCardTransactionStatus>
				</CreditCardTransaction>
				<MerchantKey>?</MerchantKey>
				<OrderKey>?</OrderKey>
				<OrderReference>?</OrderReference>
				<OrderStatus>?</OrderStatus>
			</StatusNotification>'

    parser = Nori.new(:convert_tags_to => lambda { |tag| tag })
    hash = parser.parse(xml)

    credit_card_result = create_order_result['CreditCardTransactionResultCollection'][0]
    manage_transaction_result = manage_order_result['CreditCardTransactionResultCollection'][0]

    root = hash['StatusNotification']

    root['AmountPaidInCents'] = 0
    root['CreditCardTransaction'] = {
        'Acquirer' => 'Cielo',
        'AmountInCents' =>credit_card_result['AmountInCents'],
        'AuthorizedAmountInCents'=> credit_card_result['AmountInCents'],
        'CapturedAmountInCents' =>credit_card_result['AmountInCents'],
        'CreditCardBrand' => 'Visa',
        'RefundedAmountInCents' => nil,
        'StatusChangedDate' => DateTime.now,
        'TransactionIdentifier' => Array.new(12){[*'0'..'9', *'A'..'Z'].sample}.join,
        'TransactionKey'=> credit_card_result['TransactionKey'],
        'TransactionReference'=> credit_card_result['TransactionReference'],
        'UniqueSequentialNumber' => Array.new(6){[*'0'..'9'].sample}.join,
        'PreviousCreditCardTransactionStatus' => credit_card_result['CreditCardTransactionStatus'],
        'CreditCardTransactionStatus' => (manage_transaction_result.nil? == true) ? 'null' : manage_transaction_result['CreditCardTransactionStatus']
    }
    root['MerchantKey'] = create_order_result['MerchantKey']
    root['OrderKey'] = create_order_result['OrderResult']['OrderKey']
    root['OrderReference'] = create_order_result['OrderResult']['OrderReference']
    root['OrderStatus'] = (manage_transaction_result.nil? == true) ? 'null' : manage_transaction_result['CreditCardTransactionStatus']

    return CGI::escapeHTML(Gyoku.xml(hash))
  end
end
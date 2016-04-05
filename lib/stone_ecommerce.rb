require 'rubygems'
require 'bundler/setup'

require 'json'
require 'rest-client'
require 'nori'
require 'rexml/document'

require_relative 'gateway/BoletoTransaction/boleto_transaction'
require_relative 'gateway/BoletoTransaction/boleto_transaction_options'
require_relative 'gateway/BoletoTransaction/boleto_transaction_report_file'

require_relative 'gateway/CreditCardTransaction/credit_card'
require_relative 'gateway/CreditCardTransaction/credit_card_transaction'
require_relative 'gateway/CreditCardTransaction/credit_card_transaction_options'
require_relative 'gateway/CreditCardTransaction/manage_credit_card_transaction'
require_relative 'gateway/CreditCardTransaction/retry_sale_credit_card_transaction'
require_relative 'gateway/CreditCardTransaction/credit_card_transaction_report_file'

require_relative 'gateway/Address/billing_address'
require_relative 'gateway/Address/buyer_address'
require_relative 'gateway/Address/delivery_address'

require_relative 'gateway/Merchant/merchant'

require_relative 'gateway/Order/order'
require_relative 'gateway/Order/order_transaction_report_file'

require_relative 'gateway/OnlineDebit/online_debit_transaction_report_file'

require_relative 'gateway/Parsers/boleto_transaction_parser'
require_relative 'gateway/Parsers/credit_card_transaction_parser'
require_relative 'gateway/Parsers/online_debit_transaction_parser'
require_relative 'gateway/Parsers/header_parser'
require_relative 'gateway/Parsers/trailer_parser'

require_relative 'gateway/Person/buyer'
require_relative 'gateway/Person/person'

require_relative 'gateway/Recurrency/recurrency'

require_relative 'gateway/Sale/create_sale_request'
require_relative 'gateway/Sale/manage_sale_request'
require_relative 'gateway/Sale/query_sale_request'
require_relative 'gateway/Sale/request_data'
require_relative 'gateway/Sale/retry_sale_options'
require_relative 'gateway/Sale/retry_sale_request'
require_relative 'gateway/Sale/sale_data'

require_relative 'gateway/ShoppingCart/shopping_cart'
require_relative 'gateway/ShoppingCart/shopping_cart_item'

require_relative 'gateway/SalesOption'
require_relative 'gateway/post_notification'
require_relative 'gateway/Gateway'
require_relative 'gateway/header'
require_relative 'gateway/Trailer'
require_relative 'gateway/transaction_report_file'
require_relative 'gateway/InstantBuyData/create_instant_buy_data_request'
require_relative 'gateway/InstantBuyData/update_instant_buy_data_request'
require_relative 'gateway/Person/create_buyer_request'

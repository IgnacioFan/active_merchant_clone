module ActiveMerchantClone
  module Billing
    # Bogus is a test gateway for ActiveMerchantClone
    class Bogus < Base
      AUTHORIZATION = "53433"

      SUCCESS_MESSAGE = "Bogus Gateway: Forced success"
      FAILURE_MESSAGE = "Bogus Gateway: Forced failure"

      NUMBER_ERROR_MESSAGE = "Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error"
      CAPTURE_ERROR_MESSAGE = "Bogus Gateway: Use authorization number ending in 1 for exception, 2 for error and anything else for success"
      REFUND_ERROR_MESSAGE = "Bogus Gateway: Use trans_id number ending in 1 for exception, 2 for error and anything else for success"
      UNSTORE_ERROR_MESSAGE = "Bogus Gateway: Use trans_id ending in 1 for success, 2 for exception and anything else for error"
      VOID_ERROR_MESSAGE = "Bogus Gateway: Use authorization number ending in 1 for exception, 2 for error and anything else for success"

      self.display_name = "Test"
      self.homepage_url = "http://example.com"
      self.supported_card_types = [:bogus]
      self.supported_countries = []

      # TODO(weilong): understand what emv payment is. consider authorize and purchase actions will need to support emv
      # https://en.wikipedia.org/wiki/EMV
      def authorize(money, paysource, options = {})
        money = amount(money)
        case paysource.number
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, {authorize_amount: money}, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {authorize_amount: money, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, NUMBER_ERROR_MESSAGE
        end
      end

      def capture(money, reference, options = {})
        money = amount(money)
        case reference
        when /1$/
          raise Error, CAPTURE_ERROR_MESSAGE
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {paid_amount: money, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          Response.new(true, SUCCESS_MESSAGE, {paid_amount: money}, test: true)
        end
      end

      def refund(money, reference, options = {})
        money = amount(money)
        case reference
        when /1$/
          raise Error, REFUND_ERROR_MESSAGE
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {paid_amount: money, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          Response.new(true, SUCCESS_MESSAGE, {paid_amount: money}, test: true)
        end
      end

      def purchase(money, paysource, options = {})
        money = amount(money)
        case paysource.number
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, {paid_amount: money}, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {paid_amount: money, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, NUMBER_ERROR_MESSAGE
        end
      end

      def store(paysource, options = {})
        case paysource.number
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, {billingid: "1"}, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {billingid: nil, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, NUMBER_ERROR_MESSAGE
        end
      end

      def unstore(reference, options = {})
        case reference
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, {}, test: true)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, UNSTORE_ERROR_MESSAGE
        end
      end

      def void(reference, options = {})
        case reference
        when /1$/
          raise Error, VOID_ERROR_MESSAGE
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {authorization: reference, error: FAILURE_MESSAGE}, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          Response.new(true, SUCCESS_MESSAGE, {authorization: reference}, test: true)
        end
      end
    end
  end
end

module ActiveMerchantClone
  module Billing
    # Bogus is a test gateway
    class Bogus < Base
      AUTHORIZATION = "53433"

      SUCCESS_MESSAGE = "Bogus Gateway: Forced success"
      FAILURE_MESSAGE = "Bogus Gateway: Forced failure"

      NUMBER_ERROR_MESSAGE = "Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error"


      self.display_name = "Test"
      self.homepage_url = "http://example.com"
      self.supported_card_types = [:bogus]
      self.supported_countries = []
      def authorize
      end

      # def credit
      # end

      # def capture
      # end

      # def refund
      # end

      # def purchase
      # end

      # def store
      # end

      # def unstore
      # end

      # def void
      # end
    end
  end
end

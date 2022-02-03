require "active_merchant_clone/billing/response"

module ActiveMerchantClone
  module Billing
    class Base
      class << self
        # add money_format, there are cents and dollars
        attr_accessor :display_name, :homepage_url, :supported_card_types

        def supported_countries=(country_codes)
          @supported_countries = country_codes.dup
        end

        def supported_countries
          @supported_countries ||= (self.superclass.supported_countries || [])
        end
      end

      # def supported_countries
      #   self.class.supported_countries
      # end

      def initialize(options = {})
        @options = options
      end

      def test?
        @options.key?(:test)
      end
    end
  end
end

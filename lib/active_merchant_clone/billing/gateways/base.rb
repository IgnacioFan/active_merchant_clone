require "active_merchant_clone/billing/response"

module ActiveMerchantClone
  module Billing
    class Base
      STANDARD_ERROR_CODE = {
        processing_error: "processing_error"
      }

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

      protected

      def normalize(field)
        case field
        when "true" then true
        when "false" then false
        when "null" then nil
        when "" then nil
        else field
        end
      end

      def amount(money)
        return nil if money.nil?
        raise ArgumentError, "money amount must be a positive Integer in cents." if money.is_a?(String)

        sprintf("%.2f", money.to_f / 100) # convert money unit as dollars
      end
    end
  end
end

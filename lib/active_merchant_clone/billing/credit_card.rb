require "active_merchant_clone/billing/model"
require "active_merchant_clone/billing/credit_card_brands"
require "active_merchant_clone/billing/credit_card_expiry_date"
require "active_merchant_clone/billing/credit_card_methods"

module ActiveMerchantClone
  module Billing
    class CreditCard < Model
      include CreditCardMethods

      DEFAULT_EXPIRY_YEAR = 20
      DEFAULT_VERIFICATION_LENGTH = 3
      MAX_CARD_NUMBER_LENGTH = 12

      class << self
        attr_accessor :require_name, :require_verification_value

        def requires_name?
          require_name
        end

        def require_verification_value?
          require_verification_value
        end

        def valid_verification_value?(code)
          (code.to_s =~ /^\d{#{DEFAULT_VERIFICATION_LENGTH}}$/) == 0
        end
      end

      self.require_name = true
      self.require_verification_value = true

      attr_accessor :first_name, :last_name, :verification_value
      attr_reader :brand, :number, :month, :year

      def brand=(value)
        @brand = value.to_s.downcase
      end

      def number=(value)
        @number = (empty?(value) ? value : value.to_s.gsub(/[^\d]/, ''))
      end

      def month=(value)
        @month = (empty?(value) ? nil : value.to_i)
      end

      def year=(value)
        @year = (empty?(value) ? nil : value.to_i)
      end

      def display_number
        self.class.mask(number)
      end

      def validate
        errors = validate_essential_attributes + validate_verification_value + validate_card_brand + validate_card_number
        errors_hash(errors)
      end

      def valid_month?
        (1..12).cover?(month)
      end

      def valid_expiry_year?
        (Time.now.year..(Time.now.year + DEFAULT_EXPIRY_YEAR)).cover?(year)
      end

      def expired?
        CreditCardExpiryDate.new(month, year).expired?
      end

      # TODO(weilong): add test mode and add number algorithms
      def valid_number?
        valid_card_number_length? &&
        valid_card_number_characters?
      end

      private

      def valid_card_number_length?
        return false if number.nil?
        number.length >= MAX_CARD_NUMBER_LENGTH
      end

      def valid_card_number_characters?
        return false if number.nil?
        !number.match(/\D/)
      end

      def validate_essential_attributes
        errors = []

        if self.class.requires_name?
          errors << [:first_name, "cannot be empty"] if empty?(first_name)
          errors << [:last_name,  "cannot be empty"] if empty?(last_name)
        end

        errors << [:month, "is required"] if empty?(month)
        errors << [:month, "is not a valid month"] unless valid_month?
        errors << [:year, "is required"] if empty?(year)
        errors << [:year, "is not a valid year"] unless valid_expiry_year?
        errors << [:year, "expired"] if expired?

        errors
      end

      def validate_verification_value
        return [] unless self.class.require_verification_value?
        errors = []

        if empty?(verification_value)
          errors << [:verification_value, "is required"]
        elsif !self.class.valid_verification_value?(verification_value)
          errors << [:verification_value, "should be #{DEFAULT_VERIFICATION_LENGTH} digits"]
        end

        errors
      end

      def validate_card_brand
        errors = []

        if empty?(brand)
          errors << [:brand, "is invalid"]
        elsif !CreditCardBrands.include_card_companies?(brand)
          errors << [:brand, "doesn't include in card companies"]
        end

        errors
      end

      # TODO(weilong): add if credit card number doen't match its company
      def validate_card_number
        errors = []

        if empty?(number)
          errors << [:number, 'is required']
        elsif !valid_number?
          errors << [:number, 'is not a valid credit card number']
        end

        errors
      end
    end
  end
end


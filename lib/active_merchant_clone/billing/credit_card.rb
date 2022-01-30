require "active_merchant_clone/billing/model"
require "active_merchant_clone/billing/credit_card_brands"
require "active_merchant_clone/billing/credit_card_expiry_date"
require "active_merchant_clone/billing/credit_card_methods"

module ActiveMerchantClone
  module Billing
    class CreditCard < Model
      include CreditCardMethods

      class << self
        attr_accessor :require_name
        # The verification value is a card security code
        attr_accessor :require_verification_value
        attr_accessor :default_verification_length

        def requires_name?
          require_name
        end

        def require_verification_value?
          require_verification_value
        end

        def valid_verification_value?(code)
          (code.to_s =~ /^\d{#{default_verification_length}}$/) == 0
        end
      end

      self.require_name = true
      self.require_verification_value = true
      self.default_verification_length = 3

      # returns or sets the first name of the card holder
      attr_accessor :first_name
      # returns or sets the last name of the card holder
      attr_accessor :last_name
      # returns the expiry month for the card
      attr_reader :month
      # returns the expiry year for the card
      attr_reader :year
      # return the card brand
      attr_reader :brand

      def brand=(value)
        value = value && value.to_s.dup
        @brand = value
      end

      # convert month, year value etc to be integer
      %w(month year start_month start_year).each do |m|
        class_eval %(
          def #{m}=(v)
            @#{m} = case v
            when "", nil, 0
              nil
            else
              v.to_i
            end
          end
        )
      end

      # returns the credit card number.
      attr_reader :number

      def number=(value)
        @number = (empty?(value) ? value : value.to_s.gsub(/[^\d]/, ''))
      end

      # returns or sets the card verification value.
      attr_accessor :verification_value

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
        (Time.now.year..(Time.now.year + 20)).cover?(year)
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
          errors << [:verification_value, "should be #{default_verification_length} digits"]
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

      def valid_card_number_length?
        return false if number.nil?
        number.length >= 12
      end

      def valid_card_number_characters?
        return false if number.nil?
        !number.match(/\D/)
      end
    end
  end
end


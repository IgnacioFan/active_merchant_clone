require "date"
require "active_merchant_clone/billing/model"
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
      def brand
        @brand
      end

      def brand=(value)
        value = value && value.to_s.dup
        @brand = value
      end
      # returns the credit card number.
      attr_reader :number

      def number=(value)
        # puts empty?(value)
        @number = (empty?(value) ? value : value.to_s.gsub(/[^\d]/, ''))
      end
      # returns or sets the card verification value.
      attr_accessor :verification_value

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

      def display_number
        self.class.mask(number)
      end

      def validate
        errors = validate_essential_attributes + validate_verification_value
        errors_hash(errors)
      end

      def expired?
        expiry_date.expired?
      end

      private

      def validate_essential_attributes
        errors = []

        if self.class.requires_name?
          errors << [:first_name, "cannot be empty"] if empty?(first_name)
          errors << [:last_name,  "cannot be empty"] if empty?(last_name)
        end

        errors << [:month, "is required"] if empty?(month)
        errors << [:month, "is not a valid month"] unless valid_month?(month)
        errors << [:year, "is required"] if empty?(year)
        errors << [:year, "is not a valid year"] unless valid_expiry_year?(year)
        errors << [:year, "expired"] if expired?

        errors
      end

      def validate_verification_value
        errors = []

        if !self.class.require_verification_value?
          errors << [:verification_value, "is required"]
        elsif !self.class.valid_verification_value?(verification_value)
          errors << [:verification_value, "should be #{default_verification_length} digits"]
        end

        errors
      end

      def expiry_date
        ExpiryDate.new(month, year)
      end

      class ExpiryDate
        attr_reader :month, :year
        def initialize(month, year)
          @month = month.to_i
          @year = year.to_i
        end

        # rescue exception is neccesary becaue month could be invalid
        def expired?
          Time.now.utc > expiration
        end

        def expiration
          Time.utc(year, month, month_days, 23, 59, 59)
        rescue ArgumentError
          Time.at(0).utc
        end

        private

        def month_days
          mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
          mdays[2] = 29 if Date.new(year).leap?
          mdays[month]
        end
      end
    end
  end
end


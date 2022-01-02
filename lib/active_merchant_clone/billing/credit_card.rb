
require "active_merchant_clone/billing/model"

module ActiveMerchantClone
  module Billing
    class CreditCard < Model
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
    end
  end
end


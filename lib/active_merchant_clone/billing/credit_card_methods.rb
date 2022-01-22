module ActiveMerchantClone
  module Billing
    # TODO(weilong): rename CreditCardVerifiable
    module CreditCardMethods
      def self.included(base)
        base.extend(ClassMethods)
      end

      def valid_month?(month)
        (1..12).cover?(month.to_i)
      end

      def valid_expiry_year?(year)
        (Time.now.year..(Time.now.year + 20)).cover?(year.to_i)
      end

      # TODO(weilong): add test mode and add number algorithms
      def valid_number?(number)
        valid_card_number_length?(number) &&
        valid_card_number_characters?(number)
      end

      module ClassMethods
        def last_digits(number)
          return "" if number.nil?
          number.length <= 4 ? number : number.slice(-4..-1)
        end

        def mask(number)
          "XXXX-XXXX-XXXX-#{last_digits(number)}"
        end
      end

      private

        def valid_card_number_length?(number)
          return false if number.nil?
          number.length >= 12
        end

        def valid_card_number_characters?(number)
          return false if number.nil?
          !number.match(/\D/)
        end
    end
  end
end

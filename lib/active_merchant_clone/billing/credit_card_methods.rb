module ActiveMerchantClone
  module Billing
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

      module ClassMethods
        def last_digits(number)
          return "" if number.nil?
          number.length <= 4 ? number : number.slice(-4..-1)
        end

        def mask(number)
          "XXXX-XXXX-XXXX-#{last_digits(number)}"
        end
      end
    end
  end
end

module ActiveMerchantClone
  module Billing
    module CreditCardMethods
      def self.included(base)
        base.extend(ClassMethods)
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

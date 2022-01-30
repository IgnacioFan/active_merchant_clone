# purpose: provide credit_card object a few methods to validate attributes
#
module ActiveMerchantClone
  module Billing
    module CreditCardMethods
      def self.included(base)
        base.extend(MaskDigits)
      end

      module MaskDigits
        def mask(number)
          "XXXX-XXXX-XXXX-#{last_digits(number)}"
        end

        def last_digits(number)
          return "" if number.nil?
          number.length <= 4 ? number : number.slice(-4..-1)
        end
      end
    end
  end
end

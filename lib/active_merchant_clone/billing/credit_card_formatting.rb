module ActiveMerchantClone
  module Billing
    module CreditCardFormatting
      # This method can be overwritten, depends on the billing gateway
      def expdate(credit_card)
        "#{format(credit_card.month, :two_digits)}#{format(credit_card.year, :two_digits)}"
      end

      def format(number, option)
        return "" if number.nil?

        case option
        when :two_digits then sprintf("%.2i", number.to_i)[-2..-1]
        when :four_digits then sprintf("%.4i", number.to_i)[-4..-1]
        when :four_digits_year then number.to_s.length == 2 ? "20#{number.to_s}" : format(number, :four_digits)
        else number
        end
      end
    end
  end
end

module ActiveMerchantClone
  module Billing
    class CreditCardBrands
      CARD_COMPANY_DETECTORS = {
        "visa" => ->(num) { num =~ /^4\d{12}(\d{3})?(\d{3})?$/ },
        "jcb" => ->(num) { num =~ /^4\d{12}(\d{3})?(\d{3})?$/ }
      }

      def self.include_card_companies?(brand)
        CARD_COMPANY_DETECTORS.keys.include?(brand)
      end
    end
  end
end

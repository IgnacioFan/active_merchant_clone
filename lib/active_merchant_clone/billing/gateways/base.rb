module ActiveMerchantClone
  module Billing
    class Base
      def initialize(options = {})
        @options = options
      end

      def test?
        @options.key?(:test)
      end
    end
  end
end

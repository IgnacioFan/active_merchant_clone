require "date"

module ActiveMerchantClone
  module Billing
    class CreditCardExpiryDate
      MONTH_DAYS = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

      attr_reader :month, :year

      def initialize(month, year)
        @month = month.to_i
        @year = year.to_i
      end

      def expired?
        Time.now.utc > expiration
      end

      def expiration
        Time.utc(year, month, month_days, 23, 59, 59)
      # rescue exception if month is invalid
      rescue ArgumentError
        Time.at(0).utc
      end

      private

      def month_days
        MONTH_DAYS[2] = 29 if Date.new(year).leap?
        MONTH_DAYS[month]
      end
    end
  end
end

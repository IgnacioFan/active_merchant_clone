module ActiveMerchantClone
  module Billing
    # TODO(weilong): consider being an individual class
    class Error < StandardError
    end

    class Response
      attr_reader :authorization, :success, :message, :params, :test, :error_code

      def initialize(success, message, params = {}, options = {})
        @success = success
        @message = message
        # TODO(weilong): add transform_keys as a helper method
        @params = params.each_with_object({}) { |(k, v), hsh| hsh[k.to_s] = v }
        @test = options[:test] || false
        @authorization = options[:authorization]
        @error_code = options[:error_code]
      end

      def success?
        success
      end

      def failure?
        !success
      end
    end
  end
end

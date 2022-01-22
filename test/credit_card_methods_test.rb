$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card_methods"
require "minitest/autorun"

class CreditCardMethodsTest < Minitest::Test

  class CreditCard
    include ActiveMerchantClone::Billing::CreditCardMethods
  end

  def setup
    @card = CreditCard.new
  end

  def test_valid_number?
    assert_equal false, @card.valid_number?("42424242424")
    assert_equal false, @card.valid_number?("42242424242bb")
    assert_equal true, @card.valid_number?("4242424242424242")
  end
end

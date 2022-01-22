$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card_brands"
require "minitest/autorun"

class CreditCardBrandsTest < Minitest::Test

  def setup
  end

  def test_include_card_companies
    assert_equal(true, ActiveMerchantClone::Billing::CreditCardBrands.include_card_companies?("visa"))
    assert_equal(false, ActiveMerchantClone::Billing::CreditCardBrands.include_card_companies?("test"))
  end
end

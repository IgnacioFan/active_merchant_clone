require "test_helper"

class CreditCardBrandsTest < Minitest::Test

  def setup
  end

  def test_include_card_companies
    assert_equal(true, ActiveMerchantClone::Billing::CreditCardBrands.include_card_companies?("visa"))
    assert_equal(false, ActiveMerchantClone::Billing::CreditCardBrands.include_card_companies?("test"))
  end
end

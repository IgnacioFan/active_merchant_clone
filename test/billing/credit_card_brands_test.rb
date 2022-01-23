require "test_helper"

class CreditCardBrandsTest < Minitest::Test

  def test_include_card_companies
    assert_equal(true, CreditCardBrands.include_card_companies?("visa"))
    assert_equal(false, CreditCardBrands.include_card_companies?("test"))
  end
end

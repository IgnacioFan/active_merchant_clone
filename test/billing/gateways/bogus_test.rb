require "test_helper"

class BogusTest < Minitest::Test
  CREDIT_CARD_SUCCESS_NUMBER = "4444333322221111"
  CREDIT_CARD_FAILURE_NUMBER = "4444333311112222"

  def setup
    @gateway = Bogus.new(
      login: "bogus",
      password: "bogus"
    )

    @valid_credit_card = credit_card(CREDIT_CARD_SUCCESS_NUMBER)
    @invalid_credit_card = credit_card(CREDIT_CARD_FAILURE_NUMBER)
  end

  def test_display_name
    assert_equal "Test", Bogus.display_name
  end

  def test_homepage_url
    assert_equal "http://example.com", Bogus.homepage_url
  end

  def test_supported_card_types
    assert_equal [:bogus], Bogus.supported_card_types
  end

  def test_supported_countries
    assert_equal [], Bogus.supported_countries
  end

  #   assert_equal(Gateway::STANDARD_ERROR_CODE[:processing_error], response.error_code)

  #   error = assert_raises(ActiveMerchantClone::Billing::Error) do
  #     @gateway.authorize(1000, credit_card("123"))
  #   end
  #   assert_equal("Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error", error.message)
  end
end

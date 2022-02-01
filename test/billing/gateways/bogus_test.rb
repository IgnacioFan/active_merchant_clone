require "test_helper"

class BogusTest < Minitest::Test
  CREDIT_CARD_SUCCESS_NUMBER = "4444333322221111"
  CREDIT_CARD_FAILURE_NUMBER = "4444222233331111"

  def setup
    @gateway = Bogus.new(
      login: "bogus",
      password: "bogus"
    )

    @credit_card = credit_card(CREDIT_CARD_SUCCESS_NUMBER)
  end

  def test_authorize
    assert @gateway.authorize(1000, @credit_card).success?

    # response = @gateway.authorize(1000, credit_card(CREDIT_CARD_FAILURE_NUMBER))
    # refute response.success?

  #   assert_equal(Gateway::STANDARD_ERROR_CODE[:processing_error], response.error_code)

  #   error = assert_raises(ActiveMerchantClone::Billing::Error) do
  #     @gateway.authorize(1000, credit_card("123"))
  #   end
  #   assert_equal("Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error", error.message)
  end
end

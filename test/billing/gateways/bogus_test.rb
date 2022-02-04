require "test_helper"

class BogusTest < Minitest::Test
  CREDIT_CARD_SUCCESS_NUMBER = "4444333322221111"
  CREDIT_CARD_FAILURE_NUMBER = "4444333311112222"

  def setup
    @gateway = Bogus.new(login: "bogus", password: "bogus")
    @valid_credit_card = credit_card(CREDIT_CARD_SUCCESS_NUMBER)
    @invalid_credit_card = credit_card(CREDIT_CARD_FAILURE_NUMBER)
    @response = Response.new(true, "Transaction successful", transid: Bogus::AUTHORIZATION)
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

  def test_authorize_success
    assert @gateway.authorize(1000, @valid_credit_card).success?
  end

  def test_authorize_failure
    response = @gateway.authorize(1000, @invalid_credit_card)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) { @gateway.authorize(1000, credit_card("123")) }
    assert_equal "Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error", error.message
  end

  def test_capture_success
    assert  @gateway.capture(1000, "1337").success?
    assert  @gateway.capture(1000, @response.params["transid"]).success?
  end

  def test_capture_failure
    response = @gateway.capture(1000, CREDIT_CARD_FAILURE_NUMBER)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.capture(1000, CREDIT_CARD_SUCCESS_NUMBER)
    end
    assert_equal "Bogus Gateway: Use authorization number ending in 1 for exception, 2 for error and anything else for success", error.message
  end

  def test_refund_success
    assert  @gateway.refund(1000, "1337").success?
    assert  @gateway.refund(1000, @response.params["transid"]).success?
  end

  def test_refund_failure
    response = @gateway.refund(1000, CREDIT_CARD_FAILURE_NUMBER)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.refund(1000, CREDIT_CARD_SUCCESS_NUMBER)
    end
    assert_equal "Bogus Gateway: Use trans_id number ending in 1 for exception, 2 for error and anything else for success", error.message
  end

  def test_purchase_success
    assert @gateway.purchase(1000, @valid_credit_card).success?
  end

  def test_purchase_failure
    response = @gateway.purchase(1000, @invalid_credit_card)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.purchase(1000, credit_card("123"))
    end
    assert_equal("Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error", error.message)
  end

  def test_store_success
    assert @gateway.store(@valid_credit_card).success?
  end

  def test_store_failure
    response = @gateway.store(@invalid_credit_card)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.store(credit_card("123"))
    end
    assert_equal("Bogus Gateway: Use CreditCard number ending in 1 for success, 2 for exception and anything else for error", error.message)
  end

  def test_unstore_success
    assert @gateway.unstore(CREDIT_CARD_SUCCESS_NUMBER).success?
  end

  def test_unstore_failure
    response = @gateway.unstore(CREDIT_CARD_FAILURE_NUMBER)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.unstore(credit_card("123"))
    end
    assert_equal("Bogus Gateway: Use trans_id ending in 1 for success, 2 for exception and anything else for error", error.message)
  end

  def test_void_success
    assert  @gateway.void("1337").success?
  end

  def test_void_failure
    assert  @gateway.void(@response.params["transid"]).success?
    response = @gateway.void(CREDIT_CARD_FAILURE_NUMBER)
    refute response.success?
    assert_equal Bogus::STANDARD_ERROR_CODE[:processing_error], response.error_code
    error = assert_raises(ActiveMerchantClone::Billing::Error) do
      @gateway.void(CREDIT_CARD_SUCCESS_NUMBER)
    end
    assert_equal("Bogus Gateway: Use authorization number ending in 1 for exception, 2 for error and anything else for success", error.message)
  end
end

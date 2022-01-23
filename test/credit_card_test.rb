require "test_helper"

class CreditCardTest < Minitest::Test

  def setup
    @credit_card = ActiveMerchantClone::Billing::CreditCard.new(
      first_name: "foo",
      last_name: "bar",
      month: "9",
      year: "2022",
      brand: "visa",
      number: "4242424242424242",
      verification_value: "424"
    )
  end

  def test_invalid_credit_card
    assert_equal "foo", @credit_card.first_name
    assert_equal "bar", @credit_card.last_name
    assert_equal "visa", @credit_card.brand
    assert_equal "4242424242424242", @credit_card.number
    assert_equal "424", @credit_card.verification_value
  end

  def test_require_verification_value?
    assert_equal(true, ActiveMerchantClone::Billing::CreditCard.require_verification_value?)
  end

  def test_valid_verification_value
    assert_equal(true, ActiveMerchantClone::Billing::CreditCard.valid_verification_value?("424"))
  end

  def test_validate
    assert_equal({}, @credit_card.validate)
  end

  def test_validate_essential_attributes
    credit_card = ActiveMerchantClone::Billing::CreditCard.new(
      first_name: "",
      last_name: "",
      month: "13",
      year: "2000",
      brand: "visa",
      number: "4242424242424242",
      verification_value: "424"
    )

    assert_equal({:first_name=>["cannot be empty"], :last_name=>["cannot be empty"], :month=>["is not a valid month"], :year=>["is not a valid year", "expired"]}, credit_card.validate)
  end

  def test_display_number
    assert_equal "XXXX-XXXX-XXXX-4242", @credit_card.display_number
  end

  def test_requires_name?
    assert_equal(true, ActiveMerchantClone::Billing::CreditCard.requires_name?)
  end
end

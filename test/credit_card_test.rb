$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card"
require "minitest/autorun"

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

  def test_validate
    assert_equal({}, @credit_card.validate)
  end

end

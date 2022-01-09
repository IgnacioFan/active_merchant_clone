$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card"
require "active_merchant_clone/billing/credit_card_formatting"
require "minitest/autorun"

class CreditCardFormattingTest < Minitest::Test
  include ActiveMerchantClone::Billing::CreditCardFormatting

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

  def test_expdate
    assert_equal("0922", expdate(@credit_card))
  end

  def test_format_two_digits
    assert_equal("22", format("2022", :two_digits))
    assert_equal("22", format(2022, :two_digits))
    assert_equal("19", format(19, :two_digits))
    assert_equal("", format(nil, :two_digits))
    assert_equal("", format("", :two_digits))
  end

  def test_format_four_digits
    assert_equal("2022", format("2022", :four_digits))
    assert_equal("2022", format(2022, :four_digits))
  end

  def test_format_four_digits_year
    assert_equal("2022", format("22", :four_digits_year))
    assert_equal("2022", format(22, :four_digits_year))
  end
end

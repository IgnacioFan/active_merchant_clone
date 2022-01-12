$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card"
require "minitest/autorun"

class ExpiryDateTest < Minitest::Test

  def test_date_last_month
    last_month = Date.today << 1
    assert_equal(true, ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(last_month.month, last_month.year).expired?)
  end

  def test_date_is_today
    today = Time.now.utc
    assert_equal(false, ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(today.month, today.year).expired?)
  end

  def test_date_in_the_future
    next_month = Date.today >> 1
    assert_equal(false, ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(next_month.month, next_month.year).expired?)
  end

  def test_invalid_date
    assert_equal(Time.at(0).utc, ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(13, 2022).expiration)
  end

  def test_month_and_year_coerced_to_integer
    expiry = ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new("12", "2021")
    assert_equal(12, expiry.month)
    assert_equal(2021, expiry.year)
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts $LOAD_PATH

require "active_merchant_clone/billing/credit_card"
require "minitest/autorun"

class ExpiryDateTest < Minitest::Test

  def test_should_be_expired
    last_month = Date.today << 1
    date = ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(last_month.month, last_month.year)
    assert_equal(true, date.expired?)
  end

  def test_today_should_not_be_expired
    today = Time.now.utc
    date = ActiveMerchantClone::Billing::CreditCard::ExpiryDate.new(today.month, today.year)
    assert_equal(false, date.expired?)
  end
end

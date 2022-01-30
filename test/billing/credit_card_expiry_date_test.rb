require "test_helper"

class CreditCardExpiryDateTest < Minitest::Test

  def test_initialize
    # force month and year to be integer
    expiry = CreditCardExpiryDate.new("12", "2021")
    assert_equal(12, expiry.month)
    assert_equal(2021, expiry.year)
  end

  def test_expired?
    # when date is last_month
    last_month = Date.today << 1
    assert_equal(true, CreditCardExpiryDate.new(last_month.month, last_month.year).expired?)

    # when date is today
    today = Time.now.utc
    assert_equal(false, CreditCardExpiryDate.new(today.month, today.year).expired?)

    # when date is last month
    next_month = Date.today >> 1
    assert_equal(false, CreditCardExpiryDate.new(next_month.month, next_month.year).expired?)
  end

  def test_expiration
    # invalid date
    assert_equal(Time.at(0).utc, CreditCardExpiryDate.new(13, 2022).expiration)
  end
end

require "test_helper"

class CreditCardMethodsTest < Minitest::Test
  include CreditCardMethods

  def test_mask
    assert_equal "XXXX-XXXX-XXXX-2424", CreditCardMethodsTest.mask("42424242424")
    assert_equal "XXXX-XXXX-XXXX-2bb", CreditCardMethodsTest.mask("2bb")
    assert_equal "XXXX-XXXX-XXXX-aabb", CreditCardMethodsTest.mask("aabb")
    assert_equal "XXXX-XXXX-XXXX-", CreditCardMethodsTest.mask("")
  end
end

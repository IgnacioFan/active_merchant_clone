$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "minitest/autorun"
# create customizable Minitest output formats
# https://github.com/minitest-reporters/minitest-reporters
require "minitest/reporters"
Minitest::Reporters.use!

require "active_merchant_clone"

# do some magic here!!
Minitest::Test.class_eval do
  include ActiveMerchantClone::Billing
end

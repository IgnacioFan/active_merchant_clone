$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "active_merchant_clone"
require "minitest/autorun"
# create customizable Minitest output formats
# https://github.com/minitest-reporters/minitest-reporters
require "minitest/reporters"
Minitest::Reporters.use!

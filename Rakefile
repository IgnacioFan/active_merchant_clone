# frozen_string_literal: true

require "bundler/gem_tasks"

require "rake"
# to execute testtask object
require "rake/testtask"

desc "Run the unit test suite"
task default: "test:billing"
task test_billing: "test:billing"
task test_gateways: "test:gateways"

namespace :test do
  Rake::TestTask.new(:billing) do |t|
    t.pattern = "test/billing/**/*_test.rb"
    t.libs << "test"
    t.verbose = false
  end

  Rake::TestTask.new(:gateways) do |t|
    t.pattern = "test/billing/gateways/**/*_test.rb"
    t.libs << "test"
    t.verbose = false
  end
end

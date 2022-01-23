# frozen_string_literal: true

require "bundler/gem_tasks"

require "rake"
# to execute testtask object
require "rake/testtask"

desc "Run the unit test suite"
task default: "test:billing"
task test_billing: "test:billing"

namespace :test do
  Rake::TestTask.new(:billing) do |t|
    t.pattern = "test/billing/**/*_test.rb"
    t.libs << "test"
    t.verbose = false
  end
end

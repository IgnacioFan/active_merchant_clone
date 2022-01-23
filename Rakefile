# frozen_string_literal: true

require "bundler/gem_tasks"

require "rake"
# to execute testtask object
require "rake/testtask"

desc "Run the unit test suite"
task default: "test:units"
task test: "test:units"

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.pattern = "test/**/*_test.rb"
    t.libs << "test"
    t.verbose = false
  end
end

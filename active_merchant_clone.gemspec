# frozen_string_literal: true

require_relative "lib/active_merchant_clone/version"

Gem::Specification.new do |spec|
  spec.name          = "active_merchant_clone"
  spec.version       = ActiveMerchantClone::VERSION
  spec.authors       = ["Weilong Fan"]
  spec.email         = ["fan01856472@gmail.com"]

  spec.summary       = "handle credit card transactions."
  spec.description   = "a learning material from Active Merchant"
  spec.homepage      = "https://github.com/IgnacioFan/active_merchant_clone"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/IgnacioFan/active_merchant_clone"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "minitest", "~> 5.8"
  spec.add_runtime_dependency "minitest-reporters", "1.5.0"
end

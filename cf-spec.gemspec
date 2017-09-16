# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cf/spec/version"

Gem::Specification.new do |spec|
  spec.name          = "cf-spec"
  spec.version       = CF::Spec::VERSION
  spec.authors       = ["Corey Innis"]
  spec.email         = ["coreyti@gmail.com"]

  spec.summary       = %q{Infrastructure integration tests and compliance for BOSH/CF.}
  spec.homepage      = "https://github.com/coreyti/cf-spec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             "highline", "~> 1.7.8"
  spec.add_dependency             "pry",      "~> 0.10.4"
  spec.add_dependency             "thor",     "~> 0.19.4"

  spec.add_development_dependency "bundler",  "~> 1.15"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "~> 3.0"
end

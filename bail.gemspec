# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bail/version'

Gem::Specification.new do |spec|
  spec.name          = "bail"
  spec.version       = Bail::VERSION
  spec.authors       = ["bjh"]
  spec.email         = ["bjh@fake.fake"]
  spec.summary       = %q{Bail out of functions early}
  spec.description   = %q{Bail out of functions early...}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end

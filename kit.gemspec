# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kit/version'

Gem::Specification.new do |spec|
  spec.name          = "usac-kit"
  spec.version       = Kit::VERSION
  spec.authors       = ["Brian Cobb"]
  spec.email         = ["bcobb@uwalumni.com"]
  spec.summary       = %q{Slim-fitting uniform for USA Cycling race results}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['{lib/**/*}'] + %w(README.md LICENSE.txt)
  spec.executables   = []
  spec.test_files    = Dir['{spec/**/*}']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "addressable"
  spec.add_runtime_dependency "http"
  spec.add_runtime_dependency "nokogiri"
end

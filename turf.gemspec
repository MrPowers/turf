# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turf/version'

Gem::Specification.new do |spec|
  spec.name          = "turf"
  spec.version       = Turf::VERSION
  spec.authors       = ["MrPowers"]
  spec.email         = ["matthewkevinpowers@gmail.com"]

  spec.summary       = %q{Sets application variables based on the environment}
  spec.description   = %q{Easily set application variables for the test, development, and production environments.  Works well with environment variables and provides a gitignored file for local overrides.}
  spec.homepage      = "https://github.com/MrPowers/turf"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end

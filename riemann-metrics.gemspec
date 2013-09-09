# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riemann/metrics/version'

Gem::Specification.new do |spec|
  spec.name          = "riemann-metrics"
  spec.version       = Riemann::Metrics::VERSION
  spec.authors       = ["George Sheppard"]
  spec.email         = ["g.sheppard@digital-science.com"]
  spec.description   = %q{Forwards ActiveSupport::Notifications to a Riemann server}
  spec.summary       = %q{Forwards ActiveSupport::Notifications to a Riemann server}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "riemann-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency 'combustion', '~> 0.5.1'
end
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "faster_support/version"

Gem::Specification.new do |spec|
  spec.name          = 'faster_support'
  spec.version       = FasterSupport::VERSION
  spec.authors       = ["Igor Alexandrov"]
  spec.email         = ["igor.alexandrov@gmail.com"]

  spec.summary = 'ActiveSupport done right'
  spec.homepage = 'https://github.com/jetrockets/faster_support'
  spec.license = "MIT"

  spec.files = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'lib/**/*', 'config/*.yml']
  spec.executables = []
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

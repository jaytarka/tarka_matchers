# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tarka_matchers/version'

Gem::Specification.new do |spec|
  spec.name          = "tarka_matchers"
  spec.version       = TarkaMatchers::VERSION
  spec.authors       = ["jaytarka"]
  spec.email         = ["jaytarka@hotmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = 'A set of rspec matchers'
  spec.description   = 'A (very) small set of rspec matchers that make it easier to write one-liner isolated routing specs. I hope to add many more routes in the future.'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "awesome_print"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency 'rspec-given'
	spec.add_development_dependency 'faker'
end

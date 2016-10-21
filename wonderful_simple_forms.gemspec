# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wonderful_simple_forms/version'

Gem::Specification.new do |spec|
  spec.name          = "wonderful_simple_forms"
  spec.version       = WonderfulSimpleForms::VERSION
  spec.authors       = ["hdf1986"]
  spec.email         = ["hugo@6700.com.ar"]

  spec.summary       = %q{An extension for Simple forms that help to automagically select the correct type of input}
  spec.homepage      = "https://github.com/hdf1986/wonderful_simple_forms"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

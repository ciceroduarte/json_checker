# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "json_checker"
  spec.version       = JsonChecker::VERSION
  spec.authors       = ["Cícero Duarte"]
  spec.email         = ["ciceroduarte1@gmail.com"]

  spec.summary       = "Write a short summary, because Rubygems requires one.}"
  spec.description   = "Write a longer description or delete this line.}"
  spec.homepage      = "https://github.com/ciceroduarte/json_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "diffy", "3.1.0"
end

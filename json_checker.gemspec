# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "json_checker"
  spec.version       = JsonChecker::VERSION
  spec.authors       = ["Cícero Duarte"]
  spec.email         = ["ciceroduarte1@gmail.com"]

  spec.summary       = %q{Validate fields and compare with others json files}
  spec.homepage      = "https://github.com/ciceroduarte/json_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["json_checker"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "diffy", "3.1.0"

end

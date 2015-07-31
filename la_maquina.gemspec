# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'la_maquina/version'

Gem::Specification.new do |spec|
  spec.name          = "la_maquina"
  spec.version       = LaMaquina::VERSION
  spec.authors       = ["Greg Orlov"]
  spec.email         = ["greg@avvo.com"]
  spec.summary       = %q{depnendency tree update notifications}
  spec.description   = %q{lets you have inter-model update notifications without having to make database connections}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"

end

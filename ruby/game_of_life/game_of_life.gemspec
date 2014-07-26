# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_of_life/version'

Gem::Specification.new do |spec|
  spec.name          = 'game_of_life'
  spec.version       = GameOfLife::VERSION
  spec.authors       = ['Joe Sak']
  spec.email         = ['joe@joesak.com']
  spec.summary       = %q{gol in ruby}
  spec.description   = %q{gol in ruby}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', "~> 1.6"
  spec.add_development_dependency 'rake', "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.0.0'
end

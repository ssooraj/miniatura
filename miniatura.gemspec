# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miniatura/version'

Gem::Specification.new do |spec|
  spec.name          = 'miniatura'
  spec.version       = Miniatura::VERSION
  spec.authors       = ['ssooraj']
  spec.email         = ['ssooraj7@gmail.com']

  spec.summary       = 'Carrierwave Video Thumbnailer.'
  spec.description   = 'Generates a thumbnail for carrierwave uploaded videos.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n") 
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'carrierwave-video', '~> 0.6.0'
  spec.add_development_dependency 'mini_exiftool', '~> 2.10.0'
end
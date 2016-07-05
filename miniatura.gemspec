# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miniatura/version'
require "miniatura/options"
require "miniatura/logger"
require "miniatura/generate_command"

Gem::Specification.new do |spec|
  spec.name          = "miniatura"
  spec.version       = Miniatura::VERSION
  spec.authors       = ["ssooraj"]
  spec.email         = ["ssooraj7@gmail.com"]

  spec.summary       = "Carrierwave Video Thumbnailer."
  spec.description   = "Generates a thumbnail carrierwave uploaded videos."
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  p spec.files         = `git ls-files`.split("\n") 
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "carrierwave-video", "~> 0.5.6"
  spec.add_development_dependency "mini_exiftool", "~> 2.7", ">= 2.7.6"
end
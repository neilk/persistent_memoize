# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'persistent_memoize/version'

# Build the gem with the 'rake gem:build' command.

Gem::Specification.new do |spec|
  spec.name      = 'persistent_memoize'
  spec.version   = PersistentMemoize::VERSION
  spec.version   = '0.0.1'
  spec.authors   = ['Neil Kandalgaonkar']
  spec.license   = 'MIT'
  spec.email     = ['neilk@brevity.org']
  spec.homepage  = 'https://github.com/neilk/persistent_memoize'
  spec.platform  = Gem::Platform::RUBY
  spec.summary   = 'Speeds up methods with caches, which persistent on disk'
  spec.has_rdoc  = true
  spec.files     = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.extra_rdoc_files  = ['README.md']
   
  spec.add_development_dependency('test-unit', '>= 2.0.2')
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.description = <<-EOF
    This allows you to cache method calls for faster execution, at the cost of 
    storage space and IO operations. The caches are kept on disk,
    persistent between executions of the program. 
  EOF
end

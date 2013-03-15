require 'rubygems'

# Build the gem with the 'rake gem:build' command.

Gem::Specification.new do |spec|
  spec.name      = 'persistent_memoize'
  spec.version   = '0.0.1'
  spec.author    = 'Neil Kandalgaonkar'
  spec.license   = 'MIT'
  spec.email     = 'neilk@neilk.net'
  spec.homepage  = 'http://www.rubyforge.org/projects/shards'
  spec.platform  = Gem::Platform::RUBY
  spec.summary   = 'Speeds up methods with caches, which persistent on disk'
  spec.test_file = 'test/test_memoize.rb'
  spec.has_rdoc  = true
  spec.files     = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.extra_rdoc_files  = ['MANIFEST', 'README', 'CHANGES']
   
  spec.add_development_dependency('test-unit', '>= 2.0.2')

  spec.description = <<-EOF
    This allows you to cache methods for faster execution, at the cost of 
    storage space and IO operations. The caches are kept on disk,
    persistent between executions of the program. 

    This library is most useful when you have a program that runs repeatedly,
    but which has to incorporate calculations or API results that rarely 
    change. 
    
    I use it to rebuild a static blog, which is based on my postings 
    on other sites. Those postings rarely change, and looking them up is 
    time-consuming, so it's easier to cache them all locally. But if they 
    do change, I just remove the cache files and regenerate the static blog.

    This file is based on memoize.rb by Daniel Berger 
    (https://github.com/djberg96/memoize).

    Daniel's library has a file-oriented cache but it creates a single cache file per
    method, containing all the cached results. For my workloads, this cache file 
    gets very large and rewriting it is slow. So persistent_memoize stores each result
    in its own file.
  EOF
end

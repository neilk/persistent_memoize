require 'rake'
require 'rake/testtask'
require 'rbconfig'
include RbConfig

namespace :gem do
  desc 'Build the persistent_memoize gem'
  task :build do
    spec = eval(IO.read('persistent_memoize.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc 'Install the persistent_memoize library'
  task :install => [:build] do
    file = Dir['*.gem'].first
    sh 'gem install #{file}'
  end
end

namespace :example do
  desc 'Run the fibonacci example & benchmarks'
  task :fib do
    ruby '-Ilib examples/example_fibonacci.rb'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.verbose = true
  t.warning = true
end

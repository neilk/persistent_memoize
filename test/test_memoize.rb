###############################################
# test_memoize.rb
#
# Test suite for the memoize library.
###############################################
require 'rubygems'
gem 'test-unit'

require 'test/unit'
require 'fileutils'
require 'memoize'

class TC_PersistentMemoize < Test::Unit::TestCase
   include PersistentMemoize

   def setup
      @path   = File.join((ENV['HOME'] || ENV['USERPROFILE']), 'test.cache')
   end

   def add(x, y)
     return x + y
   end

   def fib(n)
      return n if n < 2
      fib(n-1) + fib(n-2)
   end

   def factorial(n)
     f = 1
     n.downto(2) { |x| f *= x }
     f
   end

   def test_memoize
      assert_nothing_raised{ fib(5) }
      assert_nothing_raised{ memoize(:fib, @path) }
      assert_nothing_raised{ fib(50) }
      assert_equal(55, fib(10))
   end

   def test_memoize_directory_properties
      assert(!File.exists?(@path), "path did not exist")
      assert_nothing_raised{ memoize(:add, @path) }
      assert(File.exists?(@path), "path does exist")
      assert(Dir.entries(@path).select{ |f| f != '.' and f != '..' }.length == 0, "path is empty of files")
      assert_nothing_raised{ add(10, 20) }
      assert(Dir.entries(@path).select{ |f| f != '.' and f != '..' }.length == 1, "path has exactly one file")
   end
   
   def teardown
      FileUtils.remove_dir(@path) if File.exists?(@path)
   end
end

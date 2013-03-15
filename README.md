# Description
Speed up methods at the cost of disk space. Keep caches on disk to speed
up later invocations of your program.

# Installation
    gem install persistent_memoize

# Synopsis

Let's imagine we have a slow script, _fib.rb_:

    def fib(n)
      return n if n < 2
      fib(n-1) + fib(n-2)
    end

    fib(100) 

Executing it is slow. 
    
    $ fib.rb     # Slow 

So let's add memoization!

    require 'persistent_memoize'
    include PersistentMemoize

    def fib(n)
      return n if n < 2
      fib(n-1) + fib(n-2)
    end

    memoize(:fib, '/home/myself/fib-cache')
    fib(100) 
    
Then you execute it!

    $ fib.rb     # Noticeably faster 

And again...
   
    $ fib.rb     # WHOA ZOMG HOW DID THIS GET SO FAST

# Constants
    PersistentMemoize::PERSISTENT_MEMOIZE_VERSION

Returns the version of this package as a String.

# Methods
    PersistentMemoize#memoize(method, path)
Takes a _method_ (symbol) and caches the results of _method_, for 
particular arguments, on disk, in files under _path_. 

If you call _method_ again with the same arguments, _memoize_ gives
you the value from disk instead of letting the method compute the
value again.

# Acknowledgements

Based on memoize by Daniel Berg (https://github.com/djberg96/memoize)

Daniel also included this note in his code, so I might as well acknowledge 
these people too:

    Code borrowed from Nobu Nakada (ruby-talk:155159).
    Code borrowed from Ara Howard (ruby-talk:173428).
    Code borrowed from Andrew Johnson (http://tinyurl.com/8ymx8)
    Ideas taken from Brian Buckley and Sean O'Halpin.
    Tiny URL provided for Andrew Johnson because I could not find the ruby-talk
    reference. The gateway may have been broken at the time.



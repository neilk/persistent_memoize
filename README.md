# Description
Speed up methods at the cost of disk space. Keep caches on disk to speed
up later invocations of your program.

# Installation
    gem install persistent_memoize

# Synopsis

Let's imagine we have a script, _fib.rb_:

    def fib(n)
      return n if n < 2
      fib(n-1) + fib(n-2)
    end

    puts fib(40) 

Executing it is slow - on my machine, this is 20 seconds!
    
    $ time ruby fib.rb
    102334155

    real  0m20.107s
    user  0m20.067s
    sys 0m0.034s

So let's add memoization.

    require 'persistent_memoize'
    include PersistentMemoize

    def fib(n)
      return n if n < 2
      fib(n-1) + fib(n-2)
    end

    memoize(:fib, './fib-cache')
    puts fib(40) 

And executing it now takes about a tenth of a second.

    $ time ruby ./fib.rb
    102334155

    real  0m0.102s
    user  0m0.062s
    sys 0m0.036s

What's more, it stays fast - subsequent invocations after the first one are even faster.

    $ time ruby ./fib.rb
    102334155

    real  0m0.092s
    user  0m0.060s
    sys 0m0.029s

# Motivation

This library is most useful when you have a program that runs repeatedly,
but which has to incorporate calculations or API results that rarely 
change. 

I use it to rebuild a static blog, which is based on my postings 
on other sites. Those postings rarely change, and looking them up is 
time-consuming, so it's easier to cache them all locally. But if they 
do change, I just remove the cache files and regenerate the static blog.

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

Daniel's library has a file-oriented cache but it creates a single cache file per
method, containing all the cached results. For my workloads, this cache file 
gets very large and rewriting it is slow. So persistent_memoize stores each result
in its own file.

Daniel also included this note in his code, so I might as well acknowledge 
these people too:

    Code borrowed from Nobu Nakada (ruby-talk:155159).
    Code borrowed from Ara Howard (ruby-talk:173428).
    Code borrowed from Andrew Johnson (http://tinyurl.com/8ymx8)
    Ideas taken from Brian Buckley and Sean O'Halpin.
    Tiny URL provided for Andrew Johnson because I could not find the ruby-talk
    reference. The gateway may have been broken at the time.



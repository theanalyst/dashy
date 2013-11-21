DASHY
=====
[![Build Status](https://travis-ci.org/theanalyst/dashy.png?branch=master)](https://travis-ci.org/theanalyst/dashy)

Some list utilites for hy, heavily inspired by the excellent
[dash.el](https://github.com/magnars/dash.el) utility of emacs.
(While it is far from there, it is a reason for me to learn hy :) )

At present the following functions have been implemented
- `take-last` Take the last n items from a collection in reverse order
- `last` Return the last element of a collection
- `mapcat` Applies a function to collection and concats the
  results. The function must return a collection
- `partition` Returns the collection with items grouped in n sized sublists
- `flatten` Flatten a list or tuple (generators not supported atm)
- `accumulate` Make an iterator return accumulated sums (or by
  accumulating results of applying a user supplied binary function).
  Already available as a part of itertools for Python 3.3

# Blackboard

This library implements a [TupleSpace](http://en.wikipedia.org/wiki/Tuple_space) on top of [Redis](http://code.google.com/p/redis/). It is similar to [Rinda](http://www.ruby-doc.org/stdlib/libdoc/rinda/rdoc/classes/Rinda/TupleSpace.html), but the tuplespace is persisted asynchronously (thanks to Redis).

This library has been tested with Ruby 1.9!

__Note__: This library is not usable yet. This was a first shot at the process and there is a lot more work to be done.

## Dependencies

* redis
* reddis-server running
* [redis-rb gem](http://github.com/ezmobius/redis-rb)

## Installing and deploying Redis

For a preview of how to install, deploy, and monitor Redis, check out [redis-stuff](http://github.com/dambalah/redis-stuff)

## TO DO:

* Make take and write atomic
* Fix 0(n) issue: redis keys method is 0(n)

Copyright (c) 2009      Luc Castera

This program is free software. You can re-distribute and/or modify this program
under the same terms as Ruby itself.



# Blackboard

This library implements a [TupleSpace](http://en.wikipedia.org/wiki/Tuple_space) on top of [Redis](http://code.google.com/p/redis/). It is similar to [Rinda](http://www.ruby-doc.org/stdlib/libdoc/rinda/rdoc/classes/Rinda/TupleSpace.html), but the tuplespace is persisted asynchronously (thanks to Redis) and it should be much faster.


## Dependencies

* redis
* reddis-server running
* [redis-rb gem](http://github.com/ezmobius/redis-rb)


## TO DO:

* Test with Ruby 1.9
* Show benchmark of using blackboard vs using Rinda.
* Write documentation on README on how to install redis and redis-rb
* Create sample capistrano + monit recipe and post them on github, then post link to them on this README
* Create examples to show how to use it.
* Turn _read_ and _take_ calls into blocking calls (and maybe offer a non-blocking option, but default should be blocking)


Copyright (c) 2009      Luc Castera

This program is free software. You can re-distribute and/or modify this program
under the same terms as Ruby itself.



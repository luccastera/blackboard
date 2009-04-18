$LOAD_PATH.unshift(File.dirname(__FILE__))

module Blackboard
  VERSION = '2009.04.17'
end

require 'blackboard/exceptions'
require 'blackboard/tuple'
require 'blackboard/tuplespace'

require 'rubygems'
require 'redis'



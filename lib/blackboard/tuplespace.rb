require 'uri'

module Blackboard

  FETCH_INTERVALS = 0.001

  class TupleSpace
  
    def initialize(opts={})
      @opts = {:host => 'localhost', :port => '6379', :db => 0}.merge(opts)
      @redis = Redis.new(@opts)
    end
    
    def flush
      @redis.flush_db
    end
    
    def size
      global_size = @redis.get "global:size"
      global_size ? global_size.to_i : 0
    end
    
    def write(tuple)
      tuple = Tuple.new(tuple) if tuple.instance_of? Array
      raise InvalidTuple unless tuple.instance_of? Tuple      
      begin
        @redis.set URI.escape(tuple.to_s), Time.now
        @redis.incr "global:size"
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end      
    end
    
    def take(template)
      template = Tuple.new(template) if template.instance_of? Array
      raise InvalidTuple unless template.instance_of? Tuple
      begin
        while true
		      all_matches = @redis.keys URI.escape(template.to_s)
		      if all_matches.instance_of?(Array) && all_matches.size > 0
		        @redis.delete(all_matches.first)
		        @redis.decr "global:size"
		        return Tuple.from_s(URI.unescape(all_matches.first))
          end
          sleep FETCH_INTERVALS
        end          
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end       
    end
    
    def read(template)
      template = Tuple.new(template) if template.instance_of? Array
      raise InvalidTuple unless template.instance_of? Tuple
      begin
        while true      
          all_matches = @redis.keys URI.escape(template.to_s)
          if all_matches.instance_of?(Array) && all_matches.size > 0
            return Tuple.from_s(URI.unescape(all_matches.first))
          end
          sleep FETCH_INTERVALS
        end
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end       
    end
  
  end
  
end

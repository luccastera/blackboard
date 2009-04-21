require 'uri'

module Blackboard

  class TupleSpace
  
    def initialize
      @redis = Redis.new
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
        @redis.set URI.escape(tuple.to_s), 1
        @redis.incr "global:size"
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end      
    end
    
    def take(template)
      template = Tuple.new(template) if template.instance_of? Array
      raise InvalidTuple unless template.instance_of? Tuple
      begin
        all_matches = @redis.keys URI.escape(template.to_s)
        if all_matches.instance_of?(Array) && all_matches.size > 0
          @redis.delete(all_matches.first)
          @redis.decr "global:size"
          Tuple.from_s(URI.unescape(all_matches.first))
        else
          nil
        end
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end       
    end
    
    def read(template)
      template = Tuple.new(template) if template.instance_of? Array
      raise InvalidTuple unless template.instance_of? Tuple
      begin      
        all_matches = @redis.keys URI.escape(template.to_s)
        if all_matches.instance_of?(Array) && all_matches.size > 0
          Tuple.from_s(URI.unescape(all_matches.first))
        else
          nil
        end
      rescue Errno::ECONNREFUSED
        raise RedisServerNotAvailable
      end       
    end
  
  end
  
end

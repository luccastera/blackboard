module Blackboard

  class InvalidToken < StandardError
  end  

  class InvalidTuple < StandardError
  end
  
  class RedisServerNotAvailable < StandardError  
  end  
  
  class InvalidTupleString < StandardError
  end
  
end

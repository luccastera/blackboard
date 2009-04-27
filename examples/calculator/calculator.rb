# This example was inspired by the great www.rubyagent.com website.
# http://www.rubyagent.com/2007/05/simple-example-calculator-agent/

require '../../lib/blackboard.rb'

class SimpleCalculator
  include Blackboard

  def plus(a,b)
    a + b
  end
  
  def minus(a,b)
    a - b
  end
  
  def initialize
    @ts = TupleSpace.new
  end
  
  def main
  
    loop do
      tuple = @ts.take([:calculator, nil, nil, nil, nil])
      puts "#{Time.now} => #{tuple.inspect}"
      
      id = tuple[1]
      operation = tuple[2]
      arg1 = tuple[3]
      arg2 = tuple[4]
      
      puts "Calculator received operation ##{id} #{operation} with arguments #{arg1} and #{arg2}"
      
      res = operation == 'plus' ? plus(arg1, arg2) : minus(arg1, arg2) # perform the received operation
      
      sleep 1 # to pretend that an operation takes longer
      
      @ts.write([:result, id, res])    
    end
  
  end
  
end

SimpleCalculator.new.main

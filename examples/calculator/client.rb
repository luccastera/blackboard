# This example was inspired by the great www.rubyagent.com website.
# http://www.rubyagent.com/2007/05/simple-example-calculator-agent/

require '../../lib/blackboard.rb'

ts = Blackboard::TupleSpace.new

t1 = Time.now #the start time

# sending operation requests
id = 1 # the ID

for i in (1..5) # plus operations
  puts "Sending operation ##{id} plus with arguments #{i} and 1"
  ts.write [:calculator, id, :plus, i, 1]
  id += 1 # an unique ID value
end
for i in (5..9) # minus operations
  puts "Sending operation ##{id} minus with arguments #{i} and 1"
  ts.write [:calculator, id, :minus, i, 1]
  id += 1 # an unique ID value
end

puts "Waiting for results..."

# receiving results

i = 1
loop do
  t = ts.take([:result, nil, nil])
  if t.nil?
    next
  end  
  puts "Result ##{t[1]} = #{t[2]}"
  i += 1
  break if i > 10 # 10 request were sent
end

t2 = Time.now # the end time
puts "The operation took #{t2 - t1} seconds."


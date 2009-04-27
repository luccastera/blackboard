require 'rinda/tuplespace'
require '../lib/blackboard'
require 'benchmark'

rinda_ts = Rinda::TupleSpace.new
blackboard_ts = Blackboard::TupleSpace.new

Benchmark.bmbm do |x|
  x.report("Write - Rinda:") { 1000.times{ rinda_ts.write [:benchmark, rand] } }
  x.report("Write - Blackboard:") { 1000.times{ blackboard_ts.write [:benchmark, rand] } }  
end

puts "\n\n"

Benchmark.bmbm do |x|
  x.report("Take - Rinda:") { 500.times{ rinda_ts.take [:benchmark, nil] } }
  x.report("Take - Blackboard:") { 500.times{ blackboard_ts.take [:benchmark, nil] } }  
end

puts "\n\n"

Benchmark.bmbm do |x|
  x.report("Read - Rinda:") { 500.times{ rinda_ts.read [:benchmark, nil] } }
  x.report("Read - Blackboard:") { 500.times{ blackboard_ts.read [:benchmark, nil] } }  
end



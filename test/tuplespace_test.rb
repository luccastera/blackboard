require 'test_helper'

class TupleSpaceTest < Test::Unit::TestCase

  include Blackboard

  def setup  
    @tuplespace = Blackboard::TupleSpace.new
    @tuple = Blackboard::Tuple.new([:add, 1, 2])
    @tuplespace.flush
  end
  
  def test_should_be_able_to_write_a_tuple_to_tuplespace
    @tuplespace.write @tuple
  end
  
  def test_tuple_space_size_should_be_incremented_on_write
    assert_equal 0, @tuplespace.size
    @tuplespace.write @tuple
    assert_equal 1, @tuplespace.size
    @tuplespace.write @tuple
    assert_equal 2, @tuplespace.size         
  end  
  
  def test_read_should_not_remove_tuple
    assert_equal 0, @tuplespace.size
    @tuplespace.write @tuple
    assert_equal 1, @tuplespace.size
    tup = @tuplespace.read(Tuple.new([:add, nil, nil]))
    assert_equal 1, @tuplespace.size    
  end
  
  def test_write_then_read
    @tuplespace.write @tuple
    assert_equal @tuple, @tuplespace.read([:add, nil, nil])
    new_tuple = Tuple.new([:message, 'this'])
    @tuplespace.write(new_tuple)
    assert_equal new_tuple, @tuplespace.read([:message, 'this'])    
  end
  
  def test_write_then_read_with_a_string_token_that_has_space
    #TODO: make this test pass
    new_tuple = Tuple.new([:message, 'this is a message'])
    @tuplespace.write(new_tuple)
    assert_equal new_tuple, @tuplespace.read([:message, 'this is a message'])      
  end
  
  def test_take_should_remove_tuple
    assert_equal 0, @tuplespace.size
    @tuplespace.write @tuple
    assert_equal 1, @tuplespace.size
    tup = @tuplespace.take(Tuple.new([:add, nil, nil]))
    assert_equal 0, @tuplespace.size      
  end

end

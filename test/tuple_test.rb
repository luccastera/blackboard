require 'test_helper'

class TupleTest < Test::Unit::TestCase

  include Blackboard
  
  def setup
    @tuple = Tuple.new([:request, :add, 1, 3])
  end
  
  def test_should_respond_to_value
    assert_respond_to @tuple, :value
  end
  
  def test_should_return_size_of_tuple
    assert_equal 4, @tuple.size
  end
  
  def test_square_brackets_should_access_element_of_tuple
    assert_equal :request, @tuple[0]
    assert_equal :add, @tuple[1]
    assert_equal 1, @tuple[2]
    assert_equal 3, @tuple[3]            
  end
  
  def test_fetch_should_access_element_of_tuple
    assert_equal :request, @tuple.fetch(0)  
    assert_equal :add, @tuple.fetch(1)
    assert_equal 1, @tuple.fetch(2)
    assert_equal 3, @tuple.fetch(3)       
  end
  
  def test_tuple_tokens_should_be_one_of_string_symbol_float_or_fixnum
    assert_nothing_raised do
      Tuple.new([:request, 'add', 1, 1.45])
    end
    assert_raise InvalidToken do
      Tuple.new([ Hash.new, 3])
    end
  end
  
  def test_tuple_token_should_not_have_colon
    assert_raise InvalidToken do
      Tuple.new([ "foo:bar", 3])
    end
  end
  
  def test_tuple_token_should_not_have_tilde
    assert_raise InvalidToken do
      Tuple.new([ "~foobar", 3])
    end  
  end
  
  def test_should_be_able_to_compare_tuples
    assert_equal Tuple.new([:request, :add, 1, 3]), @tuple
  end
  
  def test_tuples_match
    assert @tuple.match([:request, nil, nil, nil])
    assert @tuple.match([:request, :add, nil, nil])
    assert @tuple.match([nil, nil, nil, nil]) 
    assert @tuple.match([:request, :add, 1, 3])
    assert @tuple.match(Tuple.new([:request, :add, 1, 3]))
    
    assert !@tuple.match([:request, 'add', 1, 3])
    assert !@tuple.match([:add, 'add', 1, 3])
    assert !@tuple.match([:request])
  end
  
  def test_tuple_to_s
    assert_equal "tuple:~request:~add:1:3", @tuple.to_s
    assert_equal "tuple:~request:*:1:3", Tuple.new([:request,nil,1,3]).to_s
    assert_equal "tuple:request:add:1:3", Tuple.new(['request','add',1,3]).to_s
    assert_equal "tuple:*:*:*", Tuple.new([nil,nil,nil]).to_s
  end
  
  def test_create_tuple_from_s
    assert_raises InvalidTupleString do
      Tuple.from_s("request:add:1:3")
    end
    assert_equal @tuple, Tuple.from_s("tuple:~request:~add:1:3")
    assert_equal Tuple.new([nil]), Tuple.from_s("tuple:*")
    assert_equal Tuple.new([:request, 'add', 1.45, 2.45]), Tuple.from_s("tuple:~request:add:1.45:2.45")
  end

end

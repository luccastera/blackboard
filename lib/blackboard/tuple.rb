module Blackboard

  class Tuple

    ##
    # Creates a new Tuple from an array

    def initialize(ary)
      @tuple = Array.new(ary.size)
      @tuple.size.times do |i|
        raise InvalidToken unless [Fixnum,Symbol,String,Float,NilClass].map {|x| ary[i].instance_of? x }.include?(true)
        raise InvalidToken if ary[i].instance_of?(String) && ary[i].index(':')
        raise InvalidToken if ary[i].instance_of?(String) && ary[i].index('~')
        @tuple[i] = ary[i]
      end
    end
    
    def self.from_s(tuple_string)
      raise InvalidTupleString unless tuple_string.match(/^tuple:.*$/)
      tuple_string = tuple_string[6..-1] # trip tuple: from beginning of string
      ary = tuple_string.split(':')
      ary.map! do |x|
        if x.match(/^~.*$/)
          x[1..-1].to_sym
        elsif x.match(/^\*$/)
          nil
        elsif is_integer?(x)
          x.to_i
        elsif is_float?(x)
          x.to_f
        else
          x
        end
      end
      Tuple.new(ary)
    end

    ##
    # The number of elements in the tuple.
    
    def size
      @tuple.size
    end

    ##
    # Accessor method for elements of the tuple.

    def [](k)
      @tuple[k]
    end

    ##
    # Fetches item +k+ from the tuple.

    def fetch(k)
      @tuple.fetch(k)
    end

    ##
    # Return the tuple itself
    def value
      @tuple
    end
    
    def to_s
      @tuple.map do |x|
        if x.nil?
          "*"
        elsif x.instance_of? Symbol
          "~#{x.to_s}"
        else
          x.to_s
        end
      end.join(":").reverse.concat(":elput").reverse
    end
    
    def ==(tup)
      tup.class == self.class && self.value === tup.value
    end
    
    def match(tuple)
      return false unless tuple.respond_to?(:size)
      return false unless tuple.respond_to?(:fetch)
      return false unless self.size == tuple.size
      @tuple.each_with_index do |token, index|
        begin
          it = tuple.fetch(index)
        rescue
          return false
        end
        next if token.nil?
        next if it.nil?        
        next if token == it
        next if token === it
        return false
      end
      return true
    end
    
    
    private
        
		def self.numeric?(s) 
			#s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
			true if Float(s) rescue false
		end
		
		def self.is_float?(s)
		  numeric?(s) && s.to_s.rindex(".")
		end
		
		def self.is_integer?(s)
		  numeric?(s) && !s.to_s.rindex(".")
		end		
    
  end

end

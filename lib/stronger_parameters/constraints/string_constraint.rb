require 'stronger_parameters/constraints'

module StrongerParameters
  class StringConstraint < Constraint
    attr_reader :maximum_length, :minimum_length

    def initialize(options = {})
      @maximum_length = options[:maximum_length] || options[:max_length]
      @minimum_length = options[:minimum_length] || options[:min_length]
    end

    def value(v)
      if v.is_a?(String)
        if maximum_length && v.bytesize > maximum_length
          return InvalidValue.new(v, "can not be longer than #{maximum_length} bytes")
        elsif minimum_length && v.bytesize < minimum_length
          return InvalidValue.new(v, "can not be shorter than #{minimum_length} bytes")
        end

        return v
      end

      InvalidValue.new(v, 'must be a string')
    end

    def ==(other)
      super && maximum_length == other.maximum_length
    end
  end
end

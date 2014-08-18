module Qualification

  class Pattern

    attr_reader :architype

    def initialize(architype)
      @architype = architype.to_ary.freeze
    end

    def matches?(expression)
      trim_expression(expression) == architype
    end

    def trim_expression(expression)
      expression.respond_to?(:slice) && expression.slice(0, architype.length)
    end

  end

end

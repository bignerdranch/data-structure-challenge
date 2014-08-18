require 'pathname'

module Qualification

  class Builder

    attr_reader :code_scanner

    def initialize(code_scanner)
      @code_scanner = code_scanner
    end

    def build(&block)
      instance_eval(&block)
    end

    def match(pattern, failure_message=nil, &on_match)
      pattern = Pattern.new(pattern)
      if failure_message
        on_match = ->(failure) { fail Disqualified, failure_message }
      end

      code_scanner.matchers[pattern] = on_match
    end

    def scan(path)
      path = Pathname.new(path)
      code_scanner.paths << path
    end

  end

end

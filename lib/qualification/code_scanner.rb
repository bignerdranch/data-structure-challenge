require 'ripper'

module Qualification

  class CodeScanner

    attr_reader :matchers, :paths

    def initialize
      @matchers = {}
      @paths = []
    end

    def scan
      source_codes.each do |code|
        ast = Ripper.sexp(code)
        search ast do |expression|
          test expression
        end
      end
    end

    def search(sexp_or_op, &block)
      if sexp_or_op.respond_to?(:each)
        sexp_or_op.each { |s| search(s, &block) }
      end
      yield sexp_or_op
    end

    def source_codes
      return enum_for(__method__) unless block_given?

      paths.each do |path|
        path = path.join('*.rb')
        Dir[path].each do |file|
          yield File.read(file)
        end
      end
    end

    def test(expression)
      matchers.each do |pattern, on_match|
        if pattern.matches?(expression)
          on_match.call(expression)
        end
      end
    end

  end

end

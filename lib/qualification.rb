require 'qualification/builder'
require 'qualification/code_scanner'
require 'qualification/pattern'

module Qualification

  Disqualified = Class.new(StandardError)

  def self.build(&block)
    code_scanner = CodeScanner.new
    Builder.new(code_scanner).build(&block)
    code_scanner
  end

end


# class List
#   include Enumerable
# 
#   def each(&b)
#     @inner.each { |i| b.call(i) }
#   end
# 
#   def self.[](*args)
#     List.new(*args)
#   end
# 
#   def self.allocate
#     List.new
#   end
# 
#   def initialize(*args)
#     @inner = [*args]
#   end
# 
#   def []=(index, value)
#     @inner[index] = value
#   end
# 
#   def [](index)
#     @inner[index]
#   end
# 
#   def ==(r)
#     return false if @inner.count != r.count
#     @inner.lazy.zip(r).all? { |ll,rr| ll == rr }
#   end
# 
#   def shift(val=nil)
#     case val
#     when nil
#       @inner.shift
#     else
#       @inner.shift(val)
#     end
#   end
# 
#   def unshift(val=nil)
#     case val
#     when nil
#       @inner.unshift
#     else
#       @inner.unshift(val)
#     end
#   end
# 
#   def <<(value)
#     @inner << value
#     self
#   end
# 
#   def size
#     @inner.size
#   end
# 
#   def length
#     self.size
#   end
# end


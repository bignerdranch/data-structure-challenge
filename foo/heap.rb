# class Heap
#   def initialize
#     @head = nil
#     @size = 0
#   end
# 
#   def add(value)
#     if @head.nil?
#       @node = Node.new(value)
#     else
#       @head.add(value)
#     end
# 
#     @size += 1
#     while a = @size / 2
#   end
# end
# 
#   # 1 2 4 8 16 32
#   #           0
#   #     1           2
#   #  3    4      5     6
#   #7  8  9 10  11 12 13 14
#   #
#   # get 7
# class Node
#   attr_accessor :left, :right, :parent, :value, :index
#   def initialize(value, parent=nil)
#     @value = value
#     @parent = parent
#     @left = nil
#     @right = nil
#     if parent.nil?
#       @index = 0
#     else
#       @index = parent.index + 1
#     end
#   end
# 
#   def ==(right)
#     self.value == right.value
#   end
# end

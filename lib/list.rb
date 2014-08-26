# Implement List here
class List
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def self.allocate
    List.new
  end

  def self.[](*vals)
    ll = List.new
    vals.each { |v| ll.add(v) }
    ll
  end

  def add(value)
    if @head.nil?
      @head = ListNode.new(value)
      @tail = @head
    else
      tail = @tail
      @tail = ListNode.new(value)
      @tail.prev = tail
      tail.next = @tail
    end
    @size += 1
    self
  end

  def pop
    tail = @tail
    @tail = tail.prev
    @tail.next = nil unless @tail.nil?
  end

  def [](index)
    res = node_by_index(index)
    if res.nil?
      nil
    else
      res.value
    end
  end

  def []=(index, value)
    fill_array(index) if index > size
    node = node_by_index(index)
    raise IndexError if node.nil?
    node.value = value
  end

  def each
    cur = @head
    until cur.nil?
      yield cur.value if block_given?
      cur = cur.next
    end
    self
  end

  def <<(value)
    self.add(value)
    self
  end

  def size
    @size
  end

  def length
    self.size
  end

  def ==(r)
    return false if self.size != r.size
    self.lazy.zip(r).all? { |lv, rv| lv === rv }
  end

  def shift(val=1)
    if val == 1
      inner_shift
    else
      while val > 0
        ret_val.add(inner_shift)
        val -= 1
      end
      ret_val
    end
  end

  def unshift(value)
    h = @head
    @head = ListNode.new(value)
    @head.next = h
    self
  end

private
  def inner_shift
    if @head.nil?
      nil
    else
      h = @head
      @head = h.next
      h.value
    end
    @size -= 1
  end

  # Oh god this is slow
  def node_by_index(index)
    if index < 0
      neg_index(index)
    else
      pos_index(index)
    end
  end

  def pos_index(index)
    i = 0
    cur = @head
    while i < index
      cur = cur.next
      break if cur.nil?
      i += 1
    end
    cur
  end

  def neg_index(index)
    i = -1
    cur = @tail
    while i > index
      cur = cur.prev
      break if cur.nil?
      i -= 1
    end
    cur
  end

  def fill_array(index)
    size = @size
    (0..(index-size)).each { self.add(nil) }
  end
end

class ListNode
  attr_accessor :next, :prev, :value
  def initialize(value=nil)
    @value = value
    @next = nil
    @prev = nil
  end
end

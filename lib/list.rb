class List
  def self::[](*elements)
    new(elements)
  end

  def initialize(elements)
    @first = Element.new(elements.shift, NOP.new, nil)
    current = @first
    until elements.empty?
      previous = current
      current = Element.new(elements.shift, previous, nil)
      previous.next = current
    end
    @last = current
    current.next = NOP.new
  end

  def [](i)
    get_element(i).payload
  end

  def []=(i,new_element)
    normalized_index = normalize_index(i)
    element = get_element(i)
    raise IndexError if element.nop? and i < 0
    new_element = Element.new(new_element, element.previous, element.next)
    new_element.previous.next = new_element
    new_element.next.previous = new_element
    @first = new_element if normalized_index == 0
    @last = new_element if normalized_index == self.size - 1
  end

  def ==(other)
    # This works because first essentially has the whole rat tail of object in it
    @first == other.first
  end

  def shift
    return_value = @first.payload
    new_first = get_element(1)
    @first.next = nil
    new_first.previous = NOP.new
    @first = new_first
    return_value
  end

  def unshift(element)
    element = Element.new(element, NOP.new, @first)
    @first.previous = element
    @first = element
  end

  def <<(element)
    element = Element.new(element, self.last, NOP.new)
    @last.next = element
    @first = element if @last.nop?
    @last = element
    self
  end

  def size
    length = 0
    current = self.first
    until current.nop?
      current = current.next
      length += 1
    end
    length
  end

  def first
    @first ||= NOP.new
  end
  def last
    @last ||= NOP.new
  end

  private
  def normalize_index(i)
    if i < 0
      i + self.size
    else
      i
    end
  end
  def get_element(i)
    i = normalize_index(i)
    return NOP.new unless i>=0 and i<self.size
    current = @first
    until i == 0
      i -= 1
      current = current.next
    end
    current
  end

  class Element < Struct.new(:payload, :previous, :next)
    def nop?
      false
    end
  end

  class NOP
    def next=(element)
    end
    def previous=(element)
    end
    def next
      self
    end
    def previous
      self
    end
    def payload
      nil
    end
    def ==(other)
      true
    end
    def nop?
      true
    end
  end
end

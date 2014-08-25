class List
  attr_reader :first

  def self::[](*elements)
    new(elements)
  end

  def initialize(elements)
    @first = Element.new(elements.shift, :first_element, nil)
    current = @first
    until elements.empty?
      previous = current
      current = Element.new(elements.shift, previous, nil)
      previous.next = current
    end
    current.next = :last_element
  end

  def [](i)
    current = @first
    until i <= 0
      i -= 1
      current = current.next
    end
    current.payload
  end

  def ==(other)
    # This works because first essentially has the whole rat tail of object in it
    @first == other.first
  end

  class Element < Struct.new(:payload, :next, :previous)

  end
end

class List
  def self::[](*elements)
    new(elements)
  end

  def initialize(elements)
    @first = Element.new(elements.shift, :first_element, nil)
    current = @first
    until elements.empty?
      p current
      previous = current
      current = Element.new(elements.shift, previous, nil)
      previous.next = current
    end
  end

  def [](i)
    current = @first
    until i <= 0
      i -= 1
      current = current.next
    end
    current.payload
  end

  class Element < Struct.new(:payload, :next, :previous)

  end
end

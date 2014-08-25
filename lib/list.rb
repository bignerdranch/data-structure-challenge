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
    get_element(i).payload
  end

  def ==(other)
    # This works because first essentially has the whole rat tail of object in it
    @first == other.first
  end

  def shift
    return_value = @first.payload
    new_first = get_element(1)
    @first.next = nil
    new_first.previous = :first_element
    @first = new_first
    return_value
  end

  def unshift(element)
    element = Element.new(element, :first_element, @first)
    @first.previous = element
    @first = element
  end

  private
  def get_element(i)
    current = @first
    until i <= 0
      i -= 1
      current = current.next
    end
    current
  end
  class Element < Struct.new(:payload, :previous, :next)

  end
end

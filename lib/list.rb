# Implement List here
class List
  attr_reader :length

  def self.[](*args)
    new(args)
  end

  def initialize(args)
    args.each_with_index do |item, index|
      self[index] = item
    end

    @length = args.length
  end

  def [](index)
    index_at(index)
  end

  def []=(index, new_value)
    instance_variable_set(index_from(index), new_value)
  end

  def ==(other_list)
    length.times do |index|
      return false if self[index] != other_list[index]
    end
    return true
  end

  def shift
    value_at_0 = remove_index_at(0)
    value_at_1 = remove_index_at(1)
    self[0] = value_at_1
    value_at_0
  end

  def unshift(value)
    self[0] = value
  end

  def <<(value)
    index = length.nil? ? 0 : length
    self[index] = value
    self
  end

  private

  def remove_index_at(index)
    remove_instance_variable(index_from(index))
  end

  def index_at(index)
    instance_variable_get(index_from(index))
  end

  def index_from(index)
    "@i#{index}".to_sym
  end
end

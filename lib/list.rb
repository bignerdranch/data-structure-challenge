# Implement List here
class List
  attr_reader :length

  def self.[](*args)
    new(args)
  end

  def initialize(args)
    args.each_with_index do |item, index|
      instance_variable_set(index_from(index), item)
    end
    @length = args.length
  end

  def [](int)
    index_at(int)
  end

  def []=(int, new_value)
    instance_variable_set(index_from(int), new_value)
  end

  def ==(other_list)
    length.times do |int|
      return false if self[int] != other_list[int]
    end
    return true
  end

  def shift
    value_at_0 = remove_index_at(0)
    value_at_1 = remove_index_at(1)
    self[0] = value_at_1
    value_at_0
  end

  def unshift(int)
    self[0] = int
  end

  def <<(value)
    if length.nil?
      self[0] = value
    else
      self[length] = value
    end

    self
  end

  private

  def remove_index_at(int)
    remove_instance_variable(index_from(int))
  end

  def index_at(int)
    instance_variable_get(index_from(int))
  end

  def index_from(int)
    "@i#{int}".to_sym
  end
end

# Implement List here

class List
  attr_accessor :size

  # List[]
  def self.[](*items)
    new(items)
  end

  def self.allocate
    super().tap { |obj| obj.size = 0 }
  end

  def initialize(items)
    items.each_with_index do |item, i|
      instance_variable_set("@a#{i}", item)
    end
    @size = items.length.to_i
    # @first = :@a0
  end

  # list = List.new
  # list[]
  # list[0]  @a0
  def [](num)
    return nil if num > (@size - 1) || (num * -1) > @size
    instance_variable_get("@a#{num % @size}")
  end

  def ==(list)
    list.instance_variables.all? do |var|
      instance_variables.detect { |v| instance_variable_get(v) == list.instance_variable_get(var) }
    end
  end

  def shift
    removed = remove_instance_variable("@a0")
    @size -= 1
    instance_variables.each do |var|
      next if var == :@size
      num = var.to_s.scan(/\d+/).join("")
      instance_variable_set("@a#{num.to_i - 1}", instance_variable_get(var))
    end
    removed
  end

  def unshift(item)
    @size = @size.nil? ? 0 : (@size + 1)
    instance_variables.each do|var|
      next if var == :size
      num = var.to_s.scan(/\d+/).join("")
      instance_variable_set("@a#{num.to_i + 1}", instance_variable_get(var))
    end
    instance_variable_set("@a0", item)
  end

  def []=(index, item)
    if index >= 0
      diff = index - @size
      if diff > 0
        @size.upto(index).each { |num| instance_variable_set("@a#{num}", nil) }
        @size += (diff + 1)
      end
      instance_variable_set("@a#{index}", item)
    else
      raise IndexError if (index * -1) > @size
      instance_variable_set("@a#{index % @size}", item)
    end
  end

  def <<(item)
    instance_variable_set("@a#{@size.to_i}", item)
    @size = @size.nil? ? 0 : (@size + 1)
    self
  end
end
# Implement List here

class List
  attr_reader :size

  # List[]
  def self.[](*items)
    new(items)
  end

  def initialize(items)
    items.each_with_index do |item, i|
      instance_variable_set("@a#{i}", item)
    end
    @size = items.length.to_i
  end

  # list = List.new
  # list[]
  # list[0]  @a0
  def [](num)
    if num.to_s.start_with?("-")
      place = @size + num
      instance_variable_get("@a#{place}")
    else
      instance_variable_get("@a#{num}")
    end

  end

  def ==(list)
    list.instance_variables.all? do |var|
      self.instance_variables.detect { |v| instance_variable_get(v) == list.instance_variable_get(var) }
    end
  end

  def shift
    removed = remove_instance_variable("@a0")
    @size = @size.nil? ? 0 : (@size - 1)
    instance_variables.each do|var|
      next if var == :size
      num = var.to_s.scan(/\d/).join("")
      instance_variable_set("@a#{num.to_i - 1}", instance_variable_get(var))
    end
    removed
  end

  def unshift(item)
    @size = @size.nil? ? 0 : (@size + 1)
    instance_variables.each do|var|
      next if var == :size
      num = var.to_s.scan(/\d/).join("")
      instance_variable_set("@a#{num.to_i + 1}", instance_variable_get(var))
    end
    instance_variable_set("@a0", item)
  end

  def []=(index, item)
    # old_count = instance_variables.count
    instance_variables.reverse.each do |var|
      num = var.to_s.scan(/\d/).join("").to_i
      if num > index
        instance_variable_set("@a#{num.to_i + 1}", instance_variable_get(var))
      end
    end
    instance_variable_set("@a#{index}", item)

  end

  def <<(item)
    instance_variable_set("@a#{@size.to_i}", item)
    @size = @size.nil? ? 0 : (@size + 1)
    self
  end
end
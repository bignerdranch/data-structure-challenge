# Implement List here
require 'pry'

class List
  include Enumerable
  attr_reader :total

  def initialize(*args)
    @total = 0
    args.each_with_index do |value, index|
      instance_variable_set("@_" + index.to_s, value)
      @total += 1
    end
  end

  def self.[](*args)
    self.new(*args)
  end

  def each
    @total.times do |number|
      instance_variable_get("@_" + number.to_s)
    end
  end

  def [](number)
    number += @total if number < 0
    instance_variable_get("@_" + number.to_s)
  rescue NameError
    return nil
  end

  def shift
    value = remove_instance_variable("@_0")
    @total.times do |number|
      unless number == 0
        x = instance_variable_get("@_" + number.to_s)
        instance_variable_set("@_" + (number-1).to_s, x)
      end
    end
    remove_instance_variable("@_" + (@total-1).to_s)
    @total -= 1
    value
  end

  def unshift(param)
    @total.times do |number|
      x = instance_variable_get("@_" + number.to_s)
      instance_variable_set("@_" + (number+1).to_s, x)
    end
    instance_variable_set("@_0".to_s, param)
    @total += 1
    self
  end

  def []=(index, value)
    if index < 0
      index += @total
      raise IndexError if index < 0
    end


    if index < @total #if value can be set directly
      instance_variable_set("@_" + index.to_s, value)
    else #if index has to be set
      index.times do |number|
        if number >= @total
          @total += 1
          instance_variable_set("@_" + number.to_s, nil)
        end
      end
      @total += 1
      instance_variable_set("@_" + index.to_s, value)
    end
  end

  def ==(other)
    if @total != other.total
      binding.pry
      return false
    end

    @total.times do |iteration|
      unless instance_variable_get("@_" + (iteration).to_s) == other.instance_variable_get("@_" + (iteration).to_s)
        return false
      end
    end

    return true
  end

  def <<(param)
    @total += 1
    instance_variable_set("@_" + @total.to_s, param)
    self
  end
end

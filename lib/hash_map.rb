require_relative 'node'

class HashMap
  attr_accessor :buckets, :size, :number_of_keys

  def initialize(size = 16)
    @size = size
    @buckets = Array.new(size)
    @number_of_keys = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    resize if @number_of_keys >= @size * 0.75

    index = hash(key) % @size

    current_node = @buckets[index]

    new_node = Node.new(key, value)

    if current_node.nil?
      @buckets[index] = new_node
      @number_of_keys += 1
    else
      while current_node
        if current_node.key == key
          current_node.value = value
          return
        end

        if current_node.next_node.nil?
          current_node.next_node = new_node
          @number_of_keys += 1
          return
        end

        current_node = current_node.next_node
      end
    end
  end

  def resize
    old_buckets = @buckets
    @size *= 2
    @buckets = Array.new(@size)
    @number_of_keys = 0

    old_buckets.each do |bucket|
      current_node = bucket
      while current_node
        set(current_node.key, current_node.value)
        current_node = current_node.next_node
      end
    end
  end

  def get(key)
    index = hash(key) % @size
    current_node = @buckets[index]

    while current_node
      return current_node.value if current_node.key == key

      current_node = current_node.next_node
    end

    nil
  end

  def has?(key)
    index = hash(key) % @size
    current_node = @buckets[index]

    while current_node
      return true if current_node.key == key

      current_node = current_node.next_node
    end

    false
  end

  def remove(key)
    index = hash(key) % @size
    current_node = @buckets[index]
    previous_node = nil

    while current_node
      if current_node.key == key
        if previous_node.nil?
          @buckets[index] = current_node.next_node
        else
          previous_node.next_node = current_node.next_node
        end

        @number_of_keys -= 1
        return current_node.value
      end

      previous_node = current_node
      current_node = current_node.next_node
    end

    nil
  end

  def length
    @number_of_keys
  end

  def clear
    @buckets = Array.new(size)
    @number_of_keys = 0
  end

  def keys
    keys = []

    @buckets.each do |bucket|
      current_node = bucket

      while current_node
        keys << current_node.key
        current_node = current_node.next_node
      end
    end

    keys
  end

  def values
    values = []

    @buckets.each do |bucket|
      current_node = bucket

      while current_node
        values << current_node.value
        current_node = current_node.next_node
      end
    end

    values
  end

  def entries
    entry_strings = []

    @buckets.each do |entry|
      entry_strings << "[#{entry.key}, #{entry.value}]" unless entry.nil?
    end

    "[#{entry_strings.join(', ')}]"
  end
end

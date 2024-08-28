require_relative 'node'

class HashMap
  attr_accessor :buckets, :size

  def initialize(size = 16)
    @size = size
    @buckets = Array.new(size)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @size

    current_node = @buckets[index]

    new_node = Node(key, value)

    if current_node.nil?
      @buckets[index] = new_node
    else
      while current_node
        if current_node.key == key
          current_node.value = value
          return
        end

        if current_node.next_node.nil?
          current_node.next_node = new_node
          return
        end

        current_node = current_node.next_node
      end
    end
  end
end

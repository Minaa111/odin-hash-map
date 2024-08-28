require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('apple', 'green')

puts hash_map.entries

puts hash_map.has?('apple')
puts hash_map.has?('orange')

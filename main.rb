require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('apple', 'green')
hash_map.set('orange', 'orange')

puts hash_map.length

hash_map.remove('orange')

puts hash_map.length

hash_map.clear
puts hash_map.entries
puts hash_map.length
require_relative 'linked_list.rb'
# attr_reader :value
# attr_accessor :next_node
# def initialize(value = nil)
#   @value = value
#   @next_node = nil
# end

class HashMap
  def initialize
    @capacity = 16
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0

    key.each_char { |char| hash_code = (hash_code << 5) + char.ord }

    hash_code
  end

  def set(key, value)
    bucket_index = hash(key) % @capacity

    if pointer = key_pointer(@buckets[bucket_index], key)
      pointer.value[key] = value
    else
      @buckets[bucket_index].append({key => value})
    end
  end
private
  def key_pointer(list, key)
    pointer = list.head
    while pointer do
      return pointer if pointer.value[key]
      pointer = pointer.next_node
    end

    return nil
  end
end
my_hash = HashMap.new
my_hash.set('name1', 'Lexus')
my_hash.set('name2', 'Kuts')
my_hash.set('name22', 'Oleksii')
pp my_hash
my_hash.set('name2', 'Oleksii Kuts')
pp my_hash

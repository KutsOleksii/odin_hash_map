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

  def get(key)
    bucket_index = hash(key) % @capacity
    if pointer = key_pointer(@buckets[bucket_index], key)
      pointer.value[key]
    else
      nil
    end
  end

  def has?(key)
    get(key) ? true : false
  end

  def remove(key)
    # if key is not present in HashMap
    return nil if !has?(key)

    bucket_index = hash(key) % @capacity
    pointer = @buckets[bucket_index].head

    # if key stored in the head of LinkedList
    if pointer.value[key]
      @buckets[bucket_index].head = pointer.next_node
      @buckets[bucket_index].tail = nil if pointer.next_node.nil?
      return pointer.value[key]
    end

    while pointer do
      next_pointer = pointer.next_node

      if next_pointer.value[key]
        pointer.next_node = next_pointer.next_node
        @buckets[bucket_index].tail = pointer if pointer.next_node.nil?
        return next_pointer.value[key]
      end
      pointer = pointer.next_node
    end
  end

  def length
    @buckets.map(&:size).sum
  end

  def clear!
    @buckets.fill(nil)
  end

  def keys
    flatten.keys
  end

  def values
    flatten.values
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

  def flatten
    res = Hash.new
    @buckets.each do |ll| # linked_list
      pointer = ll.head
      while pointer do
        res.merge!(pointer.value)
        pointer = pointer.next_node
      end
    end

    return res
  end
end


my_hash = HashMap.new
my_hash.set('name1', 'Lexus')
my_hash.set('name2', 'Kuts')
my_hash.set('name22', 'Oleksii')
my_hash.set('name2', 'Oleksii Kuts')
pp my_hash
# pp my_hash.remove('name22').inspect
# pp my_hash
pp my_hash.length
pp my_hash.keys
pp my_hash.values

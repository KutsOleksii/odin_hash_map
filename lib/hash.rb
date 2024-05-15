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
    # if key present
    #   update value
    # else
    #   append value
    # end
    @buckets[bucket_index].append({key => value})
  end
end
my_hash = HashMap.new
my_hash.set('name', 'Lexus')
pp my_hash

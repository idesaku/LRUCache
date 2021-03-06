class LRU
  attr_reader :size

  def initialize(size)
    raise ArgumentError if size <= 0
      
    @size = size
    @cache = {}
    @queue = []
  end

  def put(k, v)
    raise ArgumentError if k == nil

    if @queue.size >= @size
      @cache.delete(@queue.shift)
    end

    @cache[k] = v
    @queue << k
  end

  def get(k)
    v = @queue.delete(k)
    @queue << v
    @cache[k]
  end

  def order(k)
    @queue.index(k)
  end

  def first
    @queue[0]
  end

  def resize(new_size)
    raise ArgumentError if new_size <= 0
    (@size - new_size).times {
      @cache.delete(@queue.shift)
    }
    @size = new_size
  end
end

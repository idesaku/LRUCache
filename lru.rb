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

    @cache[k] = v
    @queue << k
  end

  def get(k)
    @cache[k]
  end

  def order(k)
    @queue.index(k)
  end

  def first
    @queue[0]
  end
end

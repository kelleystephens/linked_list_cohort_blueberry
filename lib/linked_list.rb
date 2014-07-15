class LinkedList

  attr_reader :size
  # shorter way to write:
  # def size
  #   @size
  # end

  def initialize(*payloads)
    @size = 0
    payloads.each do | item_payload |
      push(item_payload)
    end
  end

  def push(value)
    @size += 1
    lli = LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def get(index)
    item = find_by_index(index)
    item.payload
  end

  def last
    get(size - 1) if @size > 0
  end

  def to_s
    result = "|"
    current_item = @first_item
    until current_item.nil?
      result << " #{current_item.payload}"
      unless current_item.last?
        result << ","
      end
      current_item = current_item.next_item
    end
    result << " |"
    result
  end

  def find_by_index (index)
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      raise IndexError if current_item == nil
      current_item = current_item.next_item
    end
    current_item
  end

  def [] (index)
    get(index)
  end

  def []= (index, value)
    item = find_by_index(index)
    item.payload = value
  end

  def delete (index)
    @size -= 1
    if index == 0
      @first_item = find_by_index(1)
    else
      # deleted item = find_by_index(index), just remove it from being pointed at or pointing to another
      prev = find_by_index(index - 1)
      new_next = find_by_index(index + 1)
      prev.next_item = new_next
    end
  end

  def index (payload)
    index = -1
    current_item = @first_item
    until current_item.nil?
      index += 1
      return index if current_item.payload == payload
      current_item = current_item.next_item
    end
  end

  def sorted?
    current_item = @first_item
    if @size <= 1
      true
    else
      until current_item.last?
        return false if current_item > current_item.next_item
        current_item = current_item.next_item
      end
      true
    end
  end

  def sort!
    current_item = @first_item
    until sorted?
      result = current_item <=> current_item.next_item
      if result == 1
        index = index(current_item.payload)
        swap_with_next(index)
        sort!
      else
        current_item = current_item.next_item
      end
    end
    self.to_s
  end

  def swap_with_next(index)
    swap_item_1 = find_by_index(index)
    swap_item_2 = find_by_index(index + 1)
    right_item = find_by_index(index + 2)
    if index > 0
      left_item = find_by_index(index - 1)
      left_item.next_item = swap_item_2
      swap_item_2.next_item = swap_item_1
      swap_item_1.next_item = right_item
    else
      @first_item = swap_item_2
      swap_item_2.next_item = swap_item_1
      swap_item_1.next_item = right_item
    end
  end

  private

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end
end

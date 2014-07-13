class LinkedList

  def initialize(*payloads)
    @size = 0
    @contents = []
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
    @contents << lli.payload
  end

  def get(index)
    # raise IndexError if index < 0
    # current_item = @first_item
    # index.times do
    #   raise IndexError if current_item == nil
    #   current_item = current_item.next_item
    # end
    # current_item.payload
    item = find_by_index(index)
    item.payload
  end

  def size
    @size
  end

  def last
    get(size - 1) if @size > 0
  end

  def to_s
    if @size == 0
      "| |"
    else
      "| #{@contents.join(', ')} |"
    end
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
    @contents[index] = value
  end

  def delete (index)
    item = find_by_index(index)
    @size -= 1
    @contents.delete_at(index)
  end

  def index (payload)
    @contents.find_index(payload)
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

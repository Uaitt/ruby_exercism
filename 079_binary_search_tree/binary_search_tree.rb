Node = Struct.new(:data, :left, :right)

class Bst
  attr_reader :head

  def initialize(data)
    @head = Node.new(data)
  end

  def data
    head.data
  end

  def left
    head.left
  end

  def right
    head.right
  end

  def insert(data, current_node = head)
    return Node.new(data) if current_node.nil?

    if data > current_node.data
      current_node.right = insert(data, current_node.right)
    else
      current_node.left = insert(data, current_node.left)
    end
    current_node
  end

  # in order traversal
  def each(node = head, &block)
    return to_enum(:each) unless block_given?

    return if node.nil?

    each(node.left, &block)
    yield(node.data)
    each(node.right, &block)
  end
end

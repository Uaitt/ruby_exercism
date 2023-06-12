class Zipper
  attr_accessor :focus
  attr_reader :original_focus

  alias to_tree original_focus

  class << self
    def from_tree(focus)
      new(focus)
    end
  end

  def initialize(focus)
    @focus = focus
    @original_focus = focus
  end

  def up
    return nil if focus == original_focus

    self.focus = parent(focus)
    self
  end

  def left
    @focus = focus.left
    focus ? self : nil
  end

  def set_left(node)
    focus.left = node
    self
  end

  def right
    @focus = focus.right
    focus ? self : nil
  end

  def set_right(node)
    focus.right = node
    self
  end

  def value
    focus.value
  end

  def set_value(value)
    focus.value = value
    self
  end

  def ==(other)
    focus == other.focus && @original_focus == other.original_focus
  end

  private

  def parent(focus, root = original_focus)
    return root if root.left == focus || root.right == focus

    if root.left
      parent = parent(focus, root.left)
      return parent if parent
    end

    if root.right
      parent = parent(focus, root.right)
      return parent if parent
    end
  end
end

Node = Struct.new(:value, :left, :right)

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []

  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    node.children << self
    self.parent = node
  end
end

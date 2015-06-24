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
    @parent.children.select! {|x| x != self} if !parent.nil?
    node.children << self if !node.nil? && !node.children.include?(self)
    @parent = node
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "This ain't yo child!" if !@children.include?(child_node)
    @children.select! { |x| x != child_node }
    child_node.parent = nil
  end


  def dfs(target_value)
    return self if target_value == value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    return nil
  end

  def bfs(target_value)
    queue = []
    queue.unshift(self)
    until queue.empty?
      child = queue.pop
      if child.value == target_value
        return child
      else
        child.children.each { |x| queue.unshift(x)}
      end
    end
  end

  def trace_path_back
    current_node = self
    path = [current_node.value]
    while !current_node.parent.nil?
      current_node = current_node.parent
      path.unshift(current_node.value)
    end
    return path
  end

end

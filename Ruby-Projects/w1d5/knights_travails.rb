require './00_tree_node.rb'

class KnightPathFinder
  attr_accessor :pos, :move_tree, :visited_positions, :root_node

  def initialize(pos = [0,0])
    @pos = pos
    @visited_positions = [pos]
    @root_node = PolyTreeNode.new(pos)
    build_move_tree
  end

  def build_move_tree
    queue = []

    queue.unshift(root_node)

    until queue.empty?
      current_node = queue.pop
      current_pos = current_node.value
      next_moves = new_move_positions(current_pos)
      next_moves.each do |move|
        new_node = PolyTreeNode.new(move) #child node defined
        current_node.children.unshift(new_node) #add new_node to current_node's chidlren
        new_node.parent = current_node #set parent value in child node
        queue.unshift(new_node)
      end
    end
  end


  def self.valid_moves(pos)
    return [] if pos.nil?
    possible_positions = []
    directions = [[1,2], [1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    directions.each do |direction|
      possible_positions << add_coordinates(direction, pos)
    end
    possible_positions.select! do |coordinate|
      coordinate[0].between?(0,7) && coordinate[1].between?(0,7)
    end

    possible_positions
  end

  def new_move_positions(pos)
    valid_moves = self.class.valid_moves(pos)
    valid_moves.select! { |move| !visited_positions.include?(move) }
    valid_moves.each { |x| visited_positions.unshift(x)}
    valid_moves
  end

  def self.add_coordinates(array1, array2)
    [ array1[0] + array2[0], array1[1] + array2[1] ]
  end

  def find_path(end_pos)
    end_node = root_node.bfs(end_pos) #returns node with end_pos
    end_node.trace_path_back
  end


end
a= KnightPathFinder.new
p a.find_path([7,6])
p a.find_path([6,2])

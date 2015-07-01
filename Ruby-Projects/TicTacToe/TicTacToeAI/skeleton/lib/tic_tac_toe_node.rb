require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :children_arr

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children_arr = []
  end

  def losing_node?(evaluator)
    base_case = evaluate?(other_mark(evaluator))
    return base_case if !base_case.is_nil?

    if next_mover_mark == evaluator #player's turn
      losing = true
      self.children.each do |node|
        losing = false if node.losing_node?(evaluator)
      end
      return losing

    else
      self.children.each do |node|
        return true if node.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    base_case = evaluate?(evaluator)
    return base_case if !base_case.is_nil?

    if next_mover_mark == evaluator
      self.children.each do |node|
        return true if node.winning_node?(evaluator)
      end
    else
      win = false
      self.children.each do |node|
        win = true if node.winning_node?(evaluator)
      end
      win
    end
  end


  def children
    positions = []
    board.rows.each_with_index do |row, rindex|
      row.each_with_index do |item, cindex|
        if item.nil?
          positions.unshift([rindex, cindex])
        end
      end
    end
    positions.each do |pos|
      marked_board = board.dup
      marked_board[pos] = next_mover_mark
      child_node = TicTacToeNode.new(
        marked_board, other_mark(next_mover_mark),
        pos)
      self.children_arr.unshift(child_node)
    end
  end


  def other_mark(prev_mover_mark)
    (prev_mover_mark == :x) ? :o : :x
  end

  def evaluate?(evaluator)
    our_board = self.board
    return true if @board.winner == evaluator
    return false if @board.winner == other_mark(evaluator) || self.board.winner.is_nil?
    nil
  end
end

hp = HumanPlayer.new("Dude")
cp = ComputerPlayer::SuperComputerPlayer.new
game = TicTacToe.new(hp, cp)
game.run

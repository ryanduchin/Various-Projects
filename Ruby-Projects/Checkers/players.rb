require_relative 'keypress.rb'

class Player
  attr_accessor :name, :color

  def initialize(name = nil)
    @name = name || "Hal\##{rand(0..9)}"
    @color
  end

  def converted_color
    color == :black ? "Red" : "Yellow"
  end
end

class HumanPlayer < Player

  def get_input(board)
    loop do
      case show_single_key
      when "UP ARROW"
        new_pos = [board.cursor.first - 1, board.cursor.last]
      when "DOWN ARROW"
        new_pos = [board.cursor.first + 1, board.cursor.last]
      when "LEFT ARROW"
        new_pos = [board.cursor.first, board.cursor.last - 1]
      when "RIGHT ARROW"
        new_pos = [board.cursor.first, board.cursor.last + 1]
      when "RETURN"
        return board.cursor
      end
      board.cursor = new_pos if board.on_board?(new_pos)
      board.render
    end
  end

end

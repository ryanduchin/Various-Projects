require 'colorize'

class Piece
  attr_accessor :pos, :king
  attr_reader :color, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end

  def perform_slide?(desired_pos)
    if !board.on_board?(desired_pos) || !move_diffs[:steps].include?(desired_pos)
      return false
    else
      start_pos = pos.dup
      board.update_location(self, start_pos, desired_pos)
      @pos = desired_pos
      maybe_promote
      board.messages[:move] = "move from #{convert_pos(start_pos)} to #{convert_pos(desired_pos)}"
      board.messages[:errors] = nil
      return true
    end
  end

  def perform_jump?(desired_pos)
    if cannot_jump_conditions?(desired_pos)
      return false
    else
      start_pos = pos.dup
      board.update_location(self, start_pos, desired_pos)
      enemy_pos = board.jumped_over_pos(pos, desired_pos)
      board.update_location(board[enemy_pos], enemy_pos)
      @pos = desired_pos
      maybe_promote
      board.messages[:move] = "jump from #{convert_pos(start_pos)} to #{convert_pos(desired_pos)}"
      board.messages[:errors] = nil
      return true
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.size == 1
      if !perform_slide?(move_sequence.first)
        puts move_sequence
        puts move_sequence.first

        if !perform_jump?(move_sequence.first)
          raise InvalidMoveError.new("single move from #{convert_pos(pos)} " +
                                  "to #{convert_pos(move_sequence.first)} " +
                                  "is invalid")
        end
      end
    else
      move_sequence.each do |move|
        if !perform_jump?(move)
          raise InvalidMoveError.new("multiple jump from #{convert_pos(pos)} " +
                                  "to #{convert_pos(move_sequence.first)} " +
                                  "is invalid")
        end
      end
    end
  end

  def valid_move_seq?(move_sequence)
    begin
      new_board = @board.board_dup
      duped_piece = new_board[pos]
      duped_piece.perform_moves!(move_sequence) #ensure no error raised
      return true
    rescue InvalidMoveError => e
      board.messages[:errors] = e.message
      return false
    end
  end

  def valid_jumps_left?
    move_diffs[:jumps].any? {|move| valid_move_seq?([move])}
  end

  def valid_steps_left?
    move_diffs[:steps].any? {|move| valid_move_seq?([move])}
  end

  def perform_moves(move_sequence)
    ok_to_move = valid_move_seq?(move_sequence)
    if !ok_to_move
      raise InvalidMoveError.new(board.messages[:errors]) #can't get another raise to not ignore deeper error message
    else
      perform_moves!(move_sequence)
    end
  end

  def move_diffs
    moves = Hash.new {|h, k| h[k] = []}
    move_dir.each do |move|
      moves[:steps] << [pos.first + move * 1, pos.last + 1] <<
                      [pos.first + move * 1, pos.last - 1]
      moves[:jumps] << [pos.first + move * 2, pos.last + 2] <<
                      [pos.first + move * 2, pos.last - 2]
    end
    moves
  end

  def symbol
    sym = (king == false ? '♝' : '♚') #unicode 26c2, 26c3
    sym.colorize(convert_piece_color(color))
  end

  private

  def move_dir
    return [1, -1] if @king
    color == :black ? [-1] : [1]
  end


  def maybe_promote
    if @pos.first == 0 || @pos.first == @board.grid.size - 1
      @king = true
    end
    #optional check if correct color but shouldnt ever get called...
  end

  def convert_piece_color(color)
    color == :black ? :red : :yellow
  end

  def cannot_jump_conditions?(desired_pos)
    !board.on_board?(desired_pos) ||
    !move_diffs[:jumps].include?(desired_pos) ||
    !board.jumping_over_enemy?(self, desired_pos) ||
    !board[desired_pos].nil?
  end

  def convert_pos(pos)
    i1 = (board.grid.size - pos.first).to_s
    i2 = ('a'..'z').to_a[pos.last]
    i1 + i2
  end

end

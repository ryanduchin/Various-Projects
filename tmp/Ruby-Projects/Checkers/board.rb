require_relative 'piece.rb'
require 'colorize'

class Board
  attr_accessor :grid, :cursor, :messages
  attr_reader :grid

  def initialize(grid_size, seed = true)
    @grid = Array.new(grid_size) { Array.new(grid_size)}
    seed_board if seed
    @cursor = [grid_size/2, grid_size/2 - 1]
    @messages = Hash.new { |h,k| h[k] = []}
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def pieces
    @grid.flatten.compact
  end

  def player_pieces(color)
    pieces.select {|piece| piece.color == color}
  end

  def render
    system 'clear'
    print_board
    messages.each { |key, message| puts message } if messages
  end

  def board_dup
    new_board = Board.new(grid.size, false)
    pieces.each do |piece|
      new_board[piece.pos.dup] = Piece.new(piece.pos.dup, piece.color, new_board)
    end
    new_board
  end

  def on_board?(pos)
    pos.all? {|index| index.between?(0, grid.size - 1)}
  end


  def jumped_over_pos(start_pos, end_pos)
    x = (start_pos.first + end_pos.first)
    y = (start_pos.last + end_pos.last)
    raise IndexError.new("Jumping indices are bad") if x.odd? || y.odd?
    [x/2, y/2]
  end

  def jumping_over_enemy?(piece, end_pos)
    enemy_piece = self[jumped_over_pos(piece.pos, end_pos)]
    return true if enemy_piece && enemy_piece.color != piece.color
  end

  def update_location(piece, start_pos, end_pos = nil)
    self[start_pos] = nil
    self[end_pos] = piece if end_pos
  end

  private

  def seed_board
    color = :white
    @grid.each_with_index do |row, rindex|
      if rindex.between?(@grid.size/2 - 1, @grid.size/2)
        color = :black
      else
        row.each_with_index do |tile, cindex|
          if (rindex.odd? && cindex.odd?) || (rindex.even? && cindex.even?)
            self[[rindex, cindex]] = Piece.new([rindex, cindex], color, self)
          end
        end
      end
    end
  end

  def print_board
    square_color = :black

    grid.each_with_index do |row, rindex|
      print "#{grid.size-rindex}: "
      row.each_with_index do |piece, cindex|
        item = piece ? piece.symbol : " "
        if [rindex, cindex] == cursor
          print (item + " ").colorize(:background => :green)
        else
          print (item + " ")
            .colorize(:background => convert_tile_color(square_color))
        end
        square_color = switch_color(square_color)
      end
      print "\n"
      square_color = switch_color(square_color)
    end

    print "   "
    end_char = ('a'..'z').to_a[grid.size - 1]
    ('a'..end_char).each { |el| print el + " " }
    print "\n"
    nil
  end

  def switch_color(color)
    color == :black ? :white : :black
  end

  def convert_tile_color(color)
    color == :black ? :blue : :white
  end
end

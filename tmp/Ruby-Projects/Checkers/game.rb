require_relative 'errors.rb'
require_relative 'piece.rb'
require_relative 'board.rb'
require_relative 'players.rb'
require_relative 'keypress.rb'

class CheckersGame
  attr_accessor :board, :current_player
  attr_reader :player1, :player2

  def initialize(player1 = HumanPlayer.new, player2 = HumanPlayer.new, board_size = 8)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board = Board.new(board_size)
    @player1.color = :black
    @player2.color = :white
  end

  def play
    board.render
    until game_over?
      board.messages[:player] = ("Current turn: " +
        "#{current_player.converted_color} (#{current_player.name})")
      turn
      switch_player

    end
    switch_player
    puts "game is over, #{current_player} wins!"
  end

  def turn
    turn_over = false
    jumped_pos = nil
    begin

      until turn_over
        board.render
        if jumped_pos && no_more_jumping_moves?
          turn_over = true
          next
        elsif jumped_pos.nil? & no_more_moves?
          turn_over = true
          raise InvalidMoveError.new("#{current_player} cannot move, stalemate")
        end

        start_pos = jumped_pos || input
        moving_piece = board[start_pos]
        if moving_piece.nil?
          raise InvalidMoveError.new("There is no piece there")
        elsif moving_piece.color != current_player.color
          raise InvalidMoveError.new("You can only move your own piece!")
        end

        end_pos = input

        if start_pos == end_pos && jumped_pos
          puts "Do you want to end your turn? Press enter on same space again"
          confirm = input
          turn_over = true if end_pos == confirm
          next
        end

        is_a_step = moving_piece.move_diffs[:steps].include?(end_pos)
        is_a_jump = moving_piece.move_diffs[:jumps].include?(end_pos)

        if is_a_step && jumped_pos
          raise InvalidMoveError.new("You can only continue to jump!")
        else
          moving_piece.perform_moves([end_pos])
        end

        turn_over = is_a_step
        jumped_pos = end_pos if is_a_jump

      end

    rescue InvalidMoveError => e
      board.messages[:errors] = e.message
      retry
    end

  end

  def no_more_jumping_moves?
    board.player_pieces(current_player.color).none? do |piece|
      piece.valid_jumps_left?
    end
  end

  def no_more_moves?
    board.player_pieces(current_player.color).none? do |piece|
      piece.valid_steps_left? || piece.valid_jumps_left?
    end
  end

  def input
    current_player.get_input(board)
  end

  def switch_player
    @current_player = (current_player == player1 ? player2 : player1)
  end

  def game_over?
    board.player_pieces(current_player.color).count == 0
  end

end

g = CheckersGame.new
g.play

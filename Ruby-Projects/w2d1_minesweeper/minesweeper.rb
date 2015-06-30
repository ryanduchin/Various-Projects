require 'byebug'

DELTAS = [[0, 1], [0, -1], [1, 1], [1,-1],
                   [1,0], [-1, -1], [-1,0], [-1,1] ]

class Game
  attr_accessor :board, :viewed_positions, :over

  def initialize(board_size = 9, number_bombs = 2)
    @board = Board.new(board_size, number_bombs)
    @viewed_positions = []
    @over = false
  end

  def play
    puts "Welcome to Minesweeper."
    until over
      render
      turn
      won?
    end
    render
  end

  def reveal(i,j)
    viewed_positions << [i,j]

    board.grid[i][j].reveal = true

    if board.grid[i][j].nearby_bombs == 0

      next_positions = DELTAS.map {|(dx, dy)| [i + dx, j + dy]}
      next_positions.select! do |(x,y)|
        x.between?(0,board.grid.length-1) and
        y.between?(0,board.grid.length-1) and
        !viewed_positions.include?([x,y])
      end

      next_positions.each do |(x,y)|
        reveal(x,y)
      end
    end
  end


  def lose?(x,y)
    self.over = board.grid[x][y].bomb
    puts 'You lose!' if over
  end

  def won?
    self.over = board.grid.all? do |row|
      row.all? do |e|
        e.bomb || e.reveal
        end
      end
    puts "You win!!!" if over
  end

  def set_flags(x,y)
    if board.grid[x][y].reveal
      puts "cannot flag a revealed location"
    elsif board.grid[x][y].flag
      board.grid[x][y].flag = false
      puts "flag at #{x},#{y} removed\n"
    else
      board.grid[x][y].flag = true
      puts "flag added at #{x},#{y}\n"
    end
  end

  def turn
    puts 'Choose to check(c) a tile or flag(f) a tile. "0,0,f"'

    x,y,f = gets.chomp.split(",")
    x,y = [x,y].map {|i| i.to_i}

    if !x.between?(0,board.grid.size-1) || !y.between?(0,board.grid.size-1)
      puts "invalid position, try again"
    elsif f == "f"
      set_flags(x,y)
    else
      reveal(x,y)
      lose?(x,y)
    end
  end


  def render
    print "---"
    @board.grid.size.times {|i| print i}
    print "-\n"
    @board.grid.each_with_index do |row, i|
      print "#{i}:|"
      row.each_with_index do |el, j|
        if el.flag
          print "F"
        elsif !el.reveal
          print "*"
        elsif el.bomb
          print "!"
        elsif el.nearby_bombs == 0
          print " "
        else
          print el.nearby_bombs
        end
      end
      print "|\n"
    end
    @board.grid.size.times {print "-"}
    print "\n"
  end

end


class Board
  attr_accessor :grid, :bomb_positions

  def initialize(board_size = 9, number_bombs = 6)
    @grid = Array.new(board_size) { Array.new(board_size) }
    @bomb_positions = []
    initialize_bombs(number_bombs)
    initialize_tiles
    set_nearby_num_to_tiles
  end

  def initialize_bombs(number_bombs)
    while bomb_positions.length < number_bombs
      x = rand(0...grid.size)
      y = rand(0...grid.size)
      bomb_positions << [x,y] if !bomb_positions.include?([x,y])
    end
  end

  def initialize_tiles
    grid.each_with_index do |row, rindex|
      row.each_with_index do |el, cindex|
        grid[rindex][cindex] = Tile.new([rindex, cindex])
        if bomb_positions.include?([rindex, cindex])
          grid[rindex][cindex].bomb = true
        end
      end
    end
  end

  def set_nearby_num_to_tiles
    nearby_locations = []
    bomb_positions.each do |(x, y)|
      DELTAS.each do |(dx, dy)|
        nearby_locations << [x + dx, y + dy]
      end
    end

    nearby_locations.select! do |(x,y)|
      x.between?(0,grid.length-1) and
      y.between?(0,grid.length-1)
    end
    nearby_locations.each do |(x, y)|
      grid[x][y].nearby_bombs += 1
    end

  end

end


class Tile
  attr_accessor :bomb, :location, :nearby_bombs, :reveal, :flag

  def initialize(location)
    @bomb = false
    @location = location
    @nearby_bombs = 0
    @reveal = false
    @flag = false
  end
end
#
g = Game.new
g.play

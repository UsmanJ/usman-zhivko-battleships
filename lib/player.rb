require_relative 'ship'

class Player
  COORDINATES = [:A1, :B1, :A2, :B2]

  attr_reader :board, :hits, :misses

  def initialize
    @board = []
    @hits = []
    @misses = []
  end

  def place(ship)
    fail "Wrong coordinates" if wrong_coordinates?(ship)
    board << ship
  end

  # def fire(coordinates)
  #   fail "You shot outside the range" if !COORDINATES.include?(coordinates)
  #   return "You've hit a ship!. Game over" if last_ship
  #   return "You've hit a ship!" if struck(coordinates)
  #   return "You've missed a ship!" if missed(coordinates)
  # end

  def fire(coordinates)
    if !COORDINATES.include?(coordinates)
      fail "You shot outside the range"
    elsif last_ship?(coordinates)
      return "You've hit a ship!. Game over"
    elsif struck(coordinates)
      return "You've hit a ship!"
    else missed(coordinates)
      return "You've missed a ship!"
    end
  end


private

  def last_ship?(coordinates)
    hits << coordinates if got_hit?(coordinates) && board.length - hits.length == 1
  end

  def got_hit?(coordinates)
    board.find {|ship| ship.coordinates == coordinates}
  end

  def struck(coordinates)
    hits << coordinates if got_hit?(coordinates)
  end

  def missed(coordinates)
    misses << coordinates if !got_hit?(coordinates)
  end

  def wrong_coordinates?(ship)
    !COORDINATES.include?(ship.coordinates)
  end

end

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
    fail "Ship already in this location!" if ship_already_in_location?(ship.coordinates)
    fail "Wrong coordinates" if wrong_coordinates?(ship.coordinates)
    board << ship.coordinates
  end


  def fire(coordinates)
    fail "You shot outside the range" if wrong_coordinates?(coordinates)
    return "You've hit a ship! Game over" if last_ship?(coordinates)
    return "You've hit a ship!" if struck(coordinates)
    return "You've missed a ship!" if missed(coordinates)
  end


  private

  def ship_already_in_location?(coordinates)
    board.include?(coordinates)
  end

  def last_ship?(coordinates)
    hits << coordinates if got_hit?(coordinates) && board.length - hits.length == 1
  end

  def got_hit?(coordinates)
    board.find {|position| position == coordinates}
  end

  def struck(coordinates)
    hits << coordinates if got_hit?(coordinates)
  end

  def missed(coordinates)
    misses << coordinates if !got_hit?(coordinates)
  end

  def wrong_coordinates?(coordinates)
    !COORDINATES.include?(coordinates)
  end

end


class Ship

  def self.battleship(coordinates)
    new(coordinates, size = 2)
  end

  attr_reader :coordinates, :size

  def initialize(coordinates, size = 1, hits = 0)
    @coordinates = coordinates
    @size = size
    @hits = hits
  end
end

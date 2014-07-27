module GameOfLife
  class Location
    attr_accessor :cell, :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def self.create(attrs)
      location = new(attrs[:x], attrs[:y])
      location.cell = Cell.new(attrs)
      location
    end

    def evolve(neighbor_count)
      self.cell = cell.next_generation(neighbor_count)
      self
    end

    def has_life?
      cell.alive?
    end

    def living_neighbor?(other)
      other.has_life? &&
        [x, y] != [other.x, other.y] &&
          [x - 1, x, x + 1].include?(other.x) &&
            [y - 1, y, y + 1].include?(other.y)
    end
  end
end

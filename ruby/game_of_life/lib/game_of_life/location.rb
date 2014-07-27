module GameOfLife
  class Location
    attr_accessor :cell, :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def self.create(attrs)
      location = new(attrs[:x], attrs[:y])
      location.cell = if attrs[:life]
        LivingCell.new
      else
        DeadCell.new
      end
      location
    end

    def evolve(neighbor_count)
      if cell.alive? && cell.stays_alive?(neighbor_count)
        self.cell = cell
      elsif !cell.alive? && cell.comes_to_life?(neighbor_count)
        self.cell = LivingCell.new
      else
        self.cell = DeadCell.new
      end
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

  class DeadCell
    FERTILE_POPULATION = 3

    def alive?
      false
    end

    def comes_to_life?(neighbor_count)
      neighbor_count == FERTILE_POPULATION
    end
  end

  class LivingCell
    MIN_POPULATION = 2
    MAX_POPULATION = 3

    def alive?
      true
    end

    def stays_alive?(neighbor_count)
      (MIN_POPULATION..MAX_POPULATION).include?(neighbor_count)
    end
  end
end

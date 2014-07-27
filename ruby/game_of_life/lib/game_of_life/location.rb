module GameOfLife
  class Location
    attr_accessor :cell

    def self.create(options)
      location = new
      location.cell = if options[:life]
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

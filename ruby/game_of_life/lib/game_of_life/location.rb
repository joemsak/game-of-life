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

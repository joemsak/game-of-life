module GameOfLife
  class Cell
    attr_reader :type

    def initialize(attrs)
      if attrs[:life]
        @type = new_living_cell
      else
        @type = new_dead_cell
      end
    end

    def next_generation(neighbor_count)
      if alive? && type.stays_alive?(neighbor_count)
        @type = type
      elsif !alive? && type.comes_to_life?(neighbor_count)
        @type = new_living_cell
      else
        @type = new_dead_cell
      end
      self
    end

    def alive?
      type.alive?
    end

    def new_living_cell
      LivingCell.new
    end

    def new_dead_cell
      DeadCell.new
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

module GameOfLife
  class DeadCell
    FERTILE_POPULATION = 3

    def alive?
      false
    end

    def comes_to_life?(neighbor_count)
      neighbor_count == FERTILE_POPULATION
    end
  end
end

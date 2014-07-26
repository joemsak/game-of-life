module GameOfLife
  class World
    attr_reader :living_cells

    def initialize
      @living_cells = []
    end

    def empty?
      living_cells.count == 0
    end

    def set_living_at(location)
      living_cells << living_cell.create(location: location)
    end

    def alive_at?(location)
      true
    end

    private
    def living_cell
      LivingCell
    end
  end
end

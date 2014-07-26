module GameOfLife
  class World
    attr_accessor :living_cells

    def self.empty
      world = new
      world.living_cells = []
      world
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

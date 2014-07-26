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
      living_cells << Cell.alive(location: location)
    end

    def alive_at?(location)
      true
    end
  end
end

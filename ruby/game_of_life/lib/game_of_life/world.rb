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

    def set_coordinate(location, otions = {})
      living_cells << LivingCell.create(location: location)
      self
    end

    def alive_at?(location)
      true
    end
  end
end

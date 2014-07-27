module GameOfLife
  class World
    attr_accessor :locations

    def self.seed(location)
      world = new
      world.locations = [location]
      world
    end

    def self.empty
      world = new
      world.locations = []
      world
    end

    def tick
      locations.each do |location|
        alive_count = alive_count(location)
        location.evolve(alive_count)
      end
      self
    end

    def empty?
      locations.count == 0
    end

    def set_coordinate(location)
      locations << location
      self
    end

    def alive_count(location)
      locations.count { |loc| loc.living_neighbor?(location) }
    end
  end
end

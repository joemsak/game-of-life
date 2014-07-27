module GameOfLife
  class Location
    attr_accessor :cell

    def self.create(options, attrs = {})
      location = new
      location.cell = if options[:life]
        LivingCell.create(attrs)
      else
        DeadCell.create(attrs)
      end
      location
    end

    def has_life?
      cell.alive?
    end
  end

  module HasLocation
    def self.included(base)
      base.send(:attr_accessor, :location)
    end
  end

  module CreatesWithAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def create(attrs = {})
        instance = new
        set_attributes(instance, attrs)
        instance
      end

      private
      def set_attributes(instance, attrs)
        attrs.each { |k, v| instance.send("#{k}=", v) }
      end
    end
  end

  class DeadCell
    include HasLocation
    include CreatesWithAttributes

    FERTILE_POPULATION = 3

    def alive?
      false
    end

    def comes_to_life?(neighbor_count)
      neighbor_count == FERTILE_POPULATION
    end
  end

  class LivingCell
    include HasLocation
    include CreatesWithAttributes

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

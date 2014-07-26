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

  def comes_to_life?
    fertile_for_birth?
  end

  private
  def fertile_for_birth?
    living_neighbors.count == FERTILE_POPULATION
  end
end

class LivingCell
  include HasLocation
  include CreatesWithAttributes

  MIN_POPULATION = 2
  MAX_POPULATION = 3

  def stays_alive?
    stable_living_conditions?
  end

  private
  def stable_living_conditions?
    (MIN_POPULATION..MAX_POPULATION).include?(living_neighbors.count)
  end
end

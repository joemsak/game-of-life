class Cell
  MIN_POPULATION = 2
  MAX_POPULATION = 3
  FERTILE_POPULATION = 3

  attr_accessor :location, :alive

  def alive_in_next_generation?
    if alive
      stable_living_conditions?
    else
      fertile_for_birth?
    end
  end

  def self.alive(attrs = {})
    cell = new
    cell.alive = true
    set_attributes(cell, attrs)
    cell
  end

  def self.dead(attrs = {})
    cell = new
    cell.alive = false
    set_attributes(cell, attrs)
    cell
  end

  private
  def stable_living_conditions?
    (MIN_POPULATION..MAX_POPULATION).include?(living_neighbors.count)
  end

  def fertile_for_birth?
    living_neighbors.count == FERTILE_POPULATION
  end

  def self.set_attributes(cell, attrs)
    attrs.each { |k, v| cell.send("#{k}=", v) }
  end
end

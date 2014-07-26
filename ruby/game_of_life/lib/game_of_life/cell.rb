class LivingCell
  MIN_POPULATION = 2
  MAX_POPULATION = 3

  attr_accessor :location

  def alive_in_next_generation?
    if underpopulation?
      false
    elsif stable_living_conditions?
      true
    end
  end

  def self.create(attrs = {})
    cell = new
    attrs.each { |k, v| cell.send("#{k}=", v) }
    cell
  end

  private
  def underpopulation?
    living_neighbors.count < MIN_POPULATION
  end

  def stable_living_conditions?
    (MIN_POPULATION..MAX_POPULATION).include?(living_neighbors.count)
  end
end

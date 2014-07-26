require 'spec_helper'

class World
  attr_reader :living_cells

  def initialize
    @living_cells = []
  end

  def empty?
    !living_cells.any?
  end

  def set_living_at(x, y)
  end

  def alive_at?(x, y)
    true
  end
end

describe World, '.new' do
  it 'is empty' do
    world = World.new
    expect(world).to be_empty
  end
end

describe World, '#set_living_at' do
  it 'adds a living cell to the world' do
    world = World.new
    world.set_living_at(1, 1)
    expect(world.alive_at?(1, 1)).to be true
  end
end

describe World, '#empty?' do
  context 'when no living cells are in it' do
    it 'returns true' do
      world = World.new
      expect(world.empty?).to be true
    end
  end

  context 'when living cells are in it' do
    it 'returns false' do
      world = World.new
      cell = double(:cell)
      world.living_cells << cell
      expect(world.empty?).to be false
    end
  end
end

require 'spec_helper'

require 'game_of_life/cell'
require 'game_of_life/world'

module GameOfLife
  describe World, '.empty' do
    it 'is empty' do
      world = World.empty
      expect(world).to be_empty
    end
  end

  describe World, '#set_living_at' do
    it 'adds a living cell to the world' do
      world = World.empty
      location = double(:location)
      world.set_living_at(location)
      expect(world.alive_at?(location)).to be true
    end
  end

  describe World, '#empty?' do
    context 'when no living cells are in it' do
      it 'returns true' do
        world = World.empty
        expect(world.empty?).to be true
      end
    end

    context 'when living cells are added to it' do
      it 'returns false' do
        world = World.empty
        location = double(:location)
        world.set_living_at(location)
        expect(world.empty?).to be false
      end
    end
  end
end

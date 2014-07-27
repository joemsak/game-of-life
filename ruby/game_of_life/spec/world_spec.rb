require 'spec_helper'

require 'game_of_life/location'
require 'game_of_life/world'

module GameOfLife
  describe World, '.empty' do
    it 'is empty' do
      world = World.empty
      expect(world).to be_empty
    end
  end

  describe World, '#set_coordinate' do
    let(:world) { World.empty }
    let(:location) { double(:location) }

    subject { world.set_coordinate(location, options) }

    context 'when options[:alive] == true' do
      let(:options) { { alive: true } }
      it { should be_alive_at(location) }
    end
  end

  describe World, '#empty?' do
    context 'when living cells are added to it' do
      it 'returns false' do
        world = World.empty
        location = double(:location)
        world.set_coordinate(location)
        expect(world.empty?).to be false
      end
    end
  end
end

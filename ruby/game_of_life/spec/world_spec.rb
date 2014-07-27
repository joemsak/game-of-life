require 'spec_helper'

require 'game_of_life/world'

module GameOfLife
  describe World, '.empty' do
    subject { World.empty }
    it { should be_empty }
  end

  describe World, '.seed' do
    subject { World.seed(double.as_null_object) }
    it { should_not be_empty }
  end

  describe World, '#set_coordinate' do
    let(:world) { World.empty }
    let(:location) { double(:location) }

    it 'returns the instance' do
      expect(world.set_coordinate(location)).to be world
    end

    context 'when a location is added' do
      it "adds to the locations collection" do
        world.set_coordinate(location)
        expect(world.locations.count).to be 1
      end
    end
  end

  describe World, '#alive_at?' do
    let(:world) { World.empty }
    let(:location) { double(:location) }

    subject { world.alive_at?(location) }

    context 'when the location has no life' do
      before { allow(location).to receive(:has_life?) { false } }
      it { should be false }
    end
  end

  describe World, '#empty?' do
    let(:world) { World.empty }
    let(:location) { double(:location) }

    subject { world.empty? }

    context 'when living cells are added to it' do
      before { world.set_coordinate(location) }
      it { should be false }
    end
  end
end

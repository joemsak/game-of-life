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

  describe World, '#tick' do
    it "returns the instance" do
      world = World.empty
      expect(world.tick).to be world
    end

    it "tells each location to evolve" do
      world = World.seed(double(:location))
      world.locations.each do |location|
        allow(world).to receive(:alive_count).with(location)
        expect(location).to receive(:evolve)
      end
      world.tick
    end
  end

  describe World, '#alive_count' do
    let(:location) { double(:location) }
    let(:other_location) { double(:location) }
    let(:world) { World.seed(location) }

    context 'when the location has living neighbors' do
      before do
        allow(location).to receive(:living_neighbor?)
                           .with(other_location)
                           .and_return(true)
      end

      it 'returns the number of living neighbors' do
        expect(world.alive_count(other_location)).to be 1
      end
    end

    context 'when the location has no living neighbors' do
      before do
        allow(location).to receive(:living_neighbor?)
                           .with(other_location)
                           .and_return(false)
      end

      it 'returns 0' do
        expect(world.alive_count(other_location)).to be 0
      end
    end
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

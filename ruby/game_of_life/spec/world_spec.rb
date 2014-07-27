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
      world.locations.each { |location| expect(location).to receive(:evolve) }
      world.tick
    end

    it "updates each location in the collection" do
      world = World.seed(double.as_null_object)
      world.locations.each do |location|
        expect(world).to receive(:set_coordinate).with(location)
      end
      world.tick
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

      context 'and the location is in the collection' do
        it 'replaces the existing element in the collection' do
          location = double(:location)
          world.locations = [location]

          expect(world.locations).to receive(:[]=).with(0, location)

          world.set_coordinate(location)
        end
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

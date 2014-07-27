require 'spec_helper'

require 'game_of_life/cell'
require 'game_of_life/location'

def in_bounds_coords
  [{ x: 0, y: 2 }, { x: 1, y: 2 }, { x: 2, y: 2 },
   { x: 0, y: 1 },                 { x: 2, y: 1 },
   { x: 0, y: 0 }, { x: 1, y: 0 }, { x: 2, y: 0 }]
end

def out_of_bounds_coords
  [{ x: -1, y: 3 }, { x: 0, y: 3 }, { x: 1, y: 3 }, { x: 2, y: 3 }, { x: 3, y: 3 },
   { x: -1, y: 2 },                                                 { x: 3, y: 2 },
   { x: -1, y: 1 },                                                 { x: 3, y: 1 },
   { x: -1, y: 0 },                                                 { x: 3, y: 0 },
   { x: -1, y: -1 }, { x: 0, y: -1 }, { x: 1, y: -1 }, { x: 2, y: -1 }, { x: 3, y: -1 }]
end

module GameOfLife
  describe Location, '#living_neighbor?' do
    context 'when the location coordinates are {:x=>1, :y=>1}' do
      let(:location) { Location.create(x: 1, y: 1) }
      let(:other) { Location.create(attrs) }

      subject { location.living_neighbor?(other) }

      context 'and the other is the same location' do
        subject { location.living_neighbor?(location) }
        it { should be false }
      end

      context 'and the other somehow has the same coordinates' do
        let(:attrs) { { x: 1, y: 1, life: true } }
        it { should be false }
      end

      in_bounds_coords.each do |coords|
        context "and the other's cooridinates are #{coords}" do
          context 'and the other has life' do
            let(:attrs) { coords.merge(life: true) }
            it { should be true }
          end

          context 'and the other has no life' do
            let(:attrs) { coords }
            it { should be false }
          end
        end
      end

      out_of_bounds_coords.each do |coords|
        context "and the other has life out of bounds at #{coords}" do
          let(:attrs) { coords.merge(life: true) }
          it { should be false }
        end
      end
    end
  end

  describe Location, '#evolve' do
    let(:attrs) { {} }
    let(:neighbor_count) { double(Integer) }

    subject(:location) { Location.create(attrs) }

    before { location.evolve(neighbor_count) }

    it 'returns the instance' do
      expect(location.evolve(neighbor_count)).to eq(location)
    end

    context 'when the location has life' do
      let(:attrs) { { life: true } }

      context 'and the cell is staying alive' do
        let(:neighbor_count) { LivingCell::MAX_POPULATION }
        it { should have_life }
      end

      context 'and the cell is not staying alive' do
        let(:neighbor_count) { LivingCell::MAX_POPULATION + 1 }
        it { should_not have_life }
      end
    end

    context 'when the location does not have life' do
      context 'and the cell is not coming to life' do
        let(:neighbor_count) { DeadCell::FERTILE_POPULATION - 1 }
        it { should_not have_life }
      end

      context 'and the cell is coming to life' do
        let(:neighbor_count) { DeadCell::FERTILE_POPULATION }
        it { should have_life }
      end
    end
  end

  describe Location, '#has_life?' do
    let(:location) { Location.create(attrs) }

    subject { location.has_life? }

    context 'when the life was created' do
      let(:attrs) { { life: true } }
      it { should be true }
    end

    context 'when locations are created without attrs' do
      let(:attrs) { {} }
      it { should be false }
    end
  end

  describe LivingCell, '#stays_alive?' do
    let(:cell) { LivingCell.new }

    subject { cell.stays_alive?(count) }

    [2, 3].each do |count|
      context "when the neighbor count is #{count}" do
        let(:count) { count }
        it { should be true }
      end
    end

    [0, 1, 4, 5, 6, 7, 8].each do |count|
      context "when the neighbor count is #{count}" do
        let(:count) { count }
        it { should be false }
      end
    end
  end

  describe DeadCell, '#comes_to_life?' do
    let(:cell) { DeadCell.new }

    subject { cell.comes_to_life?(count) }

    context 'when the neighbor count is 3' do
      let(:count) { 3 }
      it { should be true }
    end

    [0, 1, 2, 4, 5, 6, 7, 8].each do |count|
      context "when the neighbor count is #{count}" do
        let(:count) { count }
        it { should be false }
      end
    end
  end
end

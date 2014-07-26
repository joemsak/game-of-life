require 'spec_helper'

require 'game_of_life/cell'

describe Cell, '#alive_in_next_generation?' do
  context 'when cell is alive' do
    let(:cell) { Cell.alive(location: double(:location)) }

    context 'when there are less than 2 live neighbors' do
      it 'returns false' do
        [0, 1].each do |count|
          allow(cell).to receive(:living_neighbors) { double(count: count) }
          expect(cell).not_to be_alive_in_next_generation
        end
      end
    end

    context 'when there are 2 or 3 live neighbors' do
      it 'returns true' do
        [2, 3].each do |count|
          allow(cell).to receive(:living_neighbors) { double(count: count) }
          expect(cell).to be_alive_in_next_generation
        end
      end
    end

    context 'when there are more than 3 live neighbors' do
      it 'returns false' do
        allow(cell).to receive(:living_neighbors) { double(count: 4) }
        expect(cell).not_to be_alive_in_next_generation
      end
    end
  end

  context 'when the cell is dead' do
    let(:cell) { Cell.dead(location: double(:location)) }

    it 'returns true for exactly 3 live neighbors' do
      allow(cell).to receive(:living_neighbors) { double(count: 3) }
      expect(cell).to be_alive_in_next_generation
    end

    it 'returns false for other counts of live neighbors' do
      [0, 1, 2, 4].each do |count|
        allow(cell).to receive(:living_neighbors) { double(count: count) }
        expect(cell).not_to be_alive_in_next_generation
      end
    end
  end
end

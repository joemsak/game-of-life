require 'spec_helper'

require 'game_of_life/cell'

describe LivingCell, '#stays_alive?' do
  let(:cell) { LivingCell.create(location: double(:location)) }

  context 'when there are less than 2 live neighbors' do
    it 'returns false' do
      [0, 1].each do |count|
        allow(cell).to receive(:living_neighbors) { double(count: count) }
        expect(cell).not_to be_stays_alive
      end
    end
  end

  context 'when there are 2 or 3 live neighbors' do
    it 'returns true' do
      [2, 3].each do |count|
        allow(cell).to receive(:living_neighbors) { double(count: count) }
        expect(cell).to be_stays_alive
      end
    end
  end

  context 'when there are more than 3 live neighbors' do
    it 'returns false' do
      allow(cell).to receive(:living_neighbors) { double(count: 4) }
      expect(cell).not_to be_stays_alive
    end
  end
end

describe DeadCell, '#comes_to_life?' do
  let(:cell) { DeadCell.create(location: double(:location)) }

  it 'returns true for exactly 3 live neighbors' do
    allow(cell).to receive(:living_neighbors) { double(count: 3) }
    expect(cell).to be_comes_to_life
  end

  it 'returns false for other counts of live neighbors' do
    [0, 1, 2, 4].each do |count|
      allow(cell).to receive(:living_neighbors) { double(count: count) }
      expect(cell).not_to be_comes_to_life
    end
  end
end

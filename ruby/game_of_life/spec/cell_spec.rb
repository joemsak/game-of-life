require 'spec_helper'

require 'game_of_life/cell'

describe LivingCell, '#alive_in_next_generation?' do
  context 'when there are less than 2 live neighbors' do
    it 'returns false' do
      cell = LivingCell.create(location: double(:location))
      [0, 1].each do |count|
        allow(cell).to receive(:living_neighbors) { double(:count => count) }
        expect(cell).not_to be_alive_in_next_generation
      end
    end
  end

  context 'when there are 2 or 3 live neighbors' do
    it 'returns true' do
      cell = LivingCell.create(location: double(:location))
      [2, 3].each do |count|
        allow(cell).to receive(:living_neighbors) { double(:count => count) }
        expect(cell).to be_alive_in_next_generation
      end
    end
  end

  context 'when there are more than 3 live neighbors' do
    it 'returns false' do
      cell = LivingCell.create(location: double(:location))
      allow(cell).to receive(:living_neighbors) { double(:count => 4) }
      expect(cell).not_to be_alive_in_next_generation
    end
  end
end

require 'spec_helper'

require 'game_of_life/cell'

module GameOfLife
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

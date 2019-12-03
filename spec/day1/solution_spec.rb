# frozen_string_literal: true

require 'day1/solution'

describe Day1::Solution do
  let(:day1_solution) { Day1::Solution.new }

  context 'masses of 12' do
    let(:masses) { [12] }

    it 'calculate fuel for mass only' do
      expect(day1_solution.calculate_fuel(masses)).to eq(2)
    end

    it 'calculate fuel for mass and additional fuel' do
      expect(day1_solution.calculate_fuel_acc(masses)).to eq(2)
    end
  end

  context 'masses of 14' do
    let(:masses) { [14] }

    it 'calculate fuel for mass only' do
      expect(day1_solution.calculate_fuel(masses)).to eq(2)
    end

    it 'calculate fuel for mass and additional fuel' do
      expect(day1_solution.calculate_fuel_acc(masses)).to eq(2)
    end
  end

  context 'masses of 1969' do
    let(:masses) { [1969] }

    it 'calculate fuel for mass only' do
      expect(day1_solution.calculate_fuel(masses)).to eq(654)
    end

    it 'calculate fuel for mass and additional fuel' do
      expect(day1_solution.calculate_fuel_acc(masses)).to eq(966)
    end
  end

  context 'masses of 14' do
    let(:masses) { [100_756] }

    it 'calculate fuel for mass only' do
      expect(day1_solution.calculate_fuel(masses)).to eq(33_583)
    end

    it 'calculate fuel for mass and additional fuel' do
      expect(day1_solution.calculate_fuel_acc(masses)).to eq(50_346)
    end
  end
end
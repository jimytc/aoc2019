# frozen_string_literal: true

require 'day3/solution'

describe Day3::Solution do
  context 'simple intersection' do
    let(:first_wire) { 'R8,U5,L5,D3' }
    let(:second_wire) { 'U7,R6,D4,L4' }
    let(:solution) { Day3::Solution.from_wire_strings(first_wire, second_wire) }

    it 'should derive 2 intersections' do
      expect(solution.intersections.count).to be(2)
    end

    it 'should derive manhattan distance as 6' do
      expect(solution.minimal_manhattan_distance).to be(6)
    end

    it 'should derive minimal wired distance as 30' do
      expect(solution.minimal_wired_distance).to be(30)
    end
  end

  context 'scenario 2' do
    let(:first_wire) { 'R75,D30,R83,U83,L12,D49,R71,U7,L72' }
    let(:second_wire) { 'U62,R66,U55,R34,D71,R55,D58,R83' }
    let(:solution) { Day3::Solution.from_wire_strings(first_wire, second_wire) }

    it 'should derive manhattan distance to 159' do
      expect(solution.minimal_manhattan_distance).to be(159)
    end

    it 'should derive minimal wired distance as 610' do
      expect(solution.minimal_wired_distance).to be(610)
    end
  end

  context 'scenario 3' do
    let(:first_wire) { 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51' }
    let(:second_wire) { 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7' }
    let(:solution) { Day3::Solution.from_wire_strings(first_wire, second_wire) }

    it 'should derive manhattan distance to 135' do
      expect(solution.minimal_manhattan_distance).to be(135)
    end

    it 'should derive minimal wired distance as 410' do
      expect(solution.minimal_wired_distance).to be(410)
    end
  end

  context 'real input' do
    before(:all) do
      @lines = File.open('input/day3/input.txt').readlines
    end

    let(:solution) { Day3::Solution.from_wire_strings(@lines[0], @lines[1]) }

    it 'calculate manhattan distance' do
      puts solution.minimal_manhattan_distance
    end

    it 'calculate manhattan distance' do
      puts solution.minimal_wired_distance
    end
  end
end

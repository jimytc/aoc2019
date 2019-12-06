# frozen_string_literal: true

require 'Day5/solution'

describe Day5::Solution do
  it 'calculate result' do
    instruction_str = File.open('input/day5/input.txt').readline
    Day5::Solution.new(5).instrument(instruction_str)
  end

  it 'jump test' do
    instruction_str = '3,3,1105,-1,9,1101,0,0,12,4,12,99,1'
    Day5::Solution.new(1).instrument(instruction_str)
  end

  it 'comparison test' do
    instruction_str = '3,9,8,9,10,9,4,9,99,-1,8'
    Day5::Solution.new(8).instrument(instruction_str)
    instruction_str = '3,9,7,9,10,9,4,9,99,-1,8'
    Day5::Solution.new(7).instrument(instruction_str)
    instruction_str = '3,3,1108,-1,8,3,4,3,99'
    Day5::Solution.new(8).instrument(instruction_str)
    instruction_str = '3,3,1107,-1,8,3,4,3,99'
    Day5::Solution.new(7).instrument(instruction_str)
  end
end

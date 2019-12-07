# frozen_string_literal: true

require 'Day6/solution'

describe Day6::Solution do
  it 'test small data' do
    orbits = %w[
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
    ]
    expect(Day6::Solution.new(orbits).orbit_count_checksum).to be(42)
  end

  it 'test you to san' do
    orbits = %w[
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
      K)YOU
      I)SAN
    ]
    expect(Day6::Solution.new(orbits).number_of_move_to_get_to_san).to be(4)
  end

  it 'calculate result' do
    orbits = File.readlines('input/day6/input.txt').map(&:strip)
    puts Day6::Solution.new(orbits).orbit_count_checksum
    puts Day6::Solution.new(orbits).number_of_move_to_get_to_san
  end
end

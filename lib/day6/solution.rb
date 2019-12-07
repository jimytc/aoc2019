# frozen_string_literal: true

module Day6
  class Solution
    def initialize(orbits)
      build_orbit_map(orbits)
    end

    def number_of_move_to_get_to_san
      orbit_line_of_me = find_orbit_connections_of('YOU')
      orbit_line_of_san = find_orbit_connections_of('SAN')
      common_node = (orbit_line_of_me & orbit_line_of_san).first
      you_to_common_steps = orbit_line_of_me.index(common_node)
      san_to_common_steps = orbit_line_of_san.index(common_node)
      you_to_common_steps + san_to_common_steps
    end

    def find_orbit_connections_of(planet)
      current_key = planet
      connection = []
      loop do
        break if @orbit_map[current_key].nil?

        connection << @orbit_map[current_key]
        current_key = @orbit_map[current_key]
      end
      connection
    end

    def orbit_count_checksum
      direct_orbits = 0
      indirect_orbits = 0
      @orbit_map.each_key do |key|
        current_key = key
        connections = 0
        loop do
          break if @orbit_map[current_key].nil?

          connections += 1
          current_key = @orbit_map[current_key]
        end
        direct_orbits += 1
        indirect_orbits += connections - 1
      end
      direct_orbits + indirect_orbits
    end

    def build_orbit_map(orbits)
      @orbit_map = {}
      @orbit_map = orbits.reduce({}) do |h, orbit|
        parent, child = orbit.split(')')
        h[child] = parent
        h[parent] ||= nil
        h
      end
    end
  end
end

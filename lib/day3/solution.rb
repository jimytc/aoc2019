# frozen_string_literal: true

module Day3
  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def transpose_x(distance)
      @x += distance
      self
    end

    def transpose_y(distance)
      @y += distance
      self
    end

    def central?
      x.zero? && y.zero?
    end
  end

  class Vector
    attr_accessor :x, :y

    def self.from_points(start_point, end_point)
      new(end_point.x - start_point.x, end_point.y - start_point.y)
    end

    def initialize(x, y)
      @x = x
      @y = y
    end

    def dot(other)
      @x * other.x + @y * other.y
    end

    def cross(other)
      @x * other.y - @y * other.x
    end

    def orthogonal?(other)
      dot(other).zero?
    end

    def parallel?(other)
      cross(other).zero?
    end
  end

  class Path
    attr_accessor :start_point, :end_point

    def initialize(start_point, end_point)
      @start_point = start_point
      @end_point = end_point
    end

    def to_vector
      Vector.from_points(start_point, end_point)
    end

    def intersect?(other)
      !to_vector.parallel?(other.to_vector)
    end

    def range_x
      min, max = [start_point.x, end_point.x].minmax
      (min..max)
    end

    def range_y
      min, max = [start_point.y, end_point.y].minmax
      (min..max)
    end

    def include?(point)
      range_x.member?(point.x) && range_y.member?(point.y)
    end

    def wired_distance_to(point)
      vector = Vector.from_points(start_point, point)
      Math.sqrt(vector.dot(vector)).to_i
    end

    def distance
      Math.sqrt(to_vector.dot(to_vector)).to_i
    end

    def intersection(other)
      return nil unless intersect?(other)

      s = Vector.from_points(start_point, other.start_point)
      factor = s.cross(other.to_vector).to_f / to_vector.cross(other.to_vector)
      new_p = Point.new(start_point.x + to_vector.x * factor,
                        start_point.y + to_vector.y * factor)
      return if new_p.central?
      return unless include?(new_p)
      return unless other.include?(new_p)

      new_p
    end
  end

  class Movement
    attr_accessor :direction, :distance

    MOVEMENT_OPS = {
      'R' => proc { |point, distance| point.transpose_x(distance) },
      'L' => proc { |point, distance| point.transpose_x(-distance) },
      'U' => proc { |point, distance| point.transpose_y(distance) },
      'D' => proc { |point, distance| point.transpose_y(-distance) }
    }.freeze

    def self.from_movement_str(movement_str)
      new(movement_str[0], movement_str[1..-1].to_i)
    end

    def initialize(direction, distance)
      @direction = direction
      @distance  = distance
    end

    def from_point(point)
      MOVEMENT_OPS[direction].call(point.dup, distance)
    end
  end

  class Wire
    attr_accessor :paths

    def initialize(path_str)
      @paths = []
      build_paths(path_str.split(','))
    end

    def intersections_with(other)
      other.paths.reduce([]) do |result, other_path|
        result += paths.map { |path| path.intersection(other_path) }.compact
        result
      end
    end

    def wired_distance_to(point)
      paths.reduce([]) do |result, path|
        break result << path.wired_distance_to(point) if path.include?(point)

        result << path.distance
      end.sum
    end

    private

    def build_paths(path_codes)
      return unless path_codes.length > 1

      points_of_wire = path_codes.each_with_object([Point.new(0, 0)]) do |movement_str, r|
        r << Movement.from_movement_str(movement_str).from_point(r.last)
      end

      points_of_wire.each_cons(2) do |start_point, end_point|
        paths << Path.new(start_point, end_point)
      end
    end
  end

  class Solution
    attr_accessor :first_wire, :second_wire

    def self.from_wire_strings(first_wire_string, second_wire_string)
      new(Wire.new(first_wire_string),
          Wire.new(second_wire_string))
    end

    def initialize(first_wire, second_wire)
      @first_wire = first_wire
      @second_wire = second_wire
    end

    def intersections
      first_wire.intersections_with(second_wire)
    end

    def minimal_manhattan_distance
      intersections.map { |p| (p.x.abs + p.y.abs).to_i }.min
    end

    def minimal_wired_distance
      intersections.map do |point|
        first_wire.wired_distance_to(point) + second_wire.wired_distance_to(point)
      end.min
    end
  end
end

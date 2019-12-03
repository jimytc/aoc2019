module Day1
  module Solution
    module_function

    def calculate_fuel(filename)
      masses = masses_from_file(filename)
      masses.reduce(0) { |r, mass| r + fuel_needed(mass) }
    end

    def calculate_fuel_acc(filename)
      masses = masses_from_file(filename)
      masses.reduce(0) { |r, mass| r + fuels_for_mass(mass).sum }
    end

    def masses_from_file(filename)
      File.readlines(filename).map(&:to_i)
    end

    def fuel_needed(mass)
      fuel = (mass.to_f / 3).floor - 2
      return 0 if fuel < 1
      fuel
    end

    def fuels_for_mass(mass, fuels = [])
      extra_fuel = fuel_needed(mass)
      return fuels if extra_fuel == 0

      fuels << extra_fuel
      fuels_for_mass(extra_fuel, fuels)
    end
  end
end
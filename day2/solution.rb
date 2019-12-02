module Day2
  module Solution
    class SignalHalt < StandardError; end

    OP_CODES = {
      1 => -> (a, b) { a + b },
      2 => -> (a, b) { a * b },
      99 => ->(a, b) { raise SignalHalt.new }
    }

    module_function

    def find_noun_verb(filename, target_output)
      original_intcodes = intcodes_from_file(filename)
      noun, verb = (0..99)
        .to_a
        .permutation(2) do |noun, verb|
          intcodes = spawn_intcodes_with_noun_and_verb(original_intcodes, noun, verb)
          result = compute_intcodes(intcodes)
          break [noun, verb] if result[0] == target_output
      end
      puts "For output #{target_output}, noun is #{noun}, verb is #{verb}"
      puts "100 * noun + verb = #{100 * noun + verb}"
      [noun, verb]
    end

    def repair_intcode_computer
      original_intcodes = intcodes_from_file(filename)
      intcodes = spawn_intcodes_with_noun_and_verb(original_intcodes, 12, 2)
      compute_intcodes(intcodes)
    end

    def compute_intcodes(intcodes)
      begin
        intcodes.each_slice(4) do |slice|
          op = OP_CODES[slice.first]
          op_result = op.call(intcodes[slice[1]], intcodes[slice[2]])
          intcodes[slice.last] = op_result
        end
      rescue SignalHalt
        "Halted!"
      end
      intcodes
    end

    def spawn_intcodes_with_noun_and_verb(intcodes, noun, verb)
      intcodes
        .dup
        .tap { |codes| codes[1] = noun }
        .tap { |codes| codes[2] = verb }
    end

    def intcodes_from_file(filename)
      File.readlines(filename).first.split(',').map(&:to_i)
    end
  end
end
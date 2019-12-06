# frozen_string_literal: true

module Day5
  class SignalHalt < StandardError
  end

  class Instruction
    def call(memory, *args)
      raise NotImplementedError
    end

    def shift_index_by
      0
    end
  end

  class AdditionInstruction < Instruction
    def call(memory, *args)
      [memory[args[2]] = args[0..1].sum, shift_index_by]
    end

    def shift_index_by
      4
    end
  end

  class MultiplyInstruction < Instruction
    def call(memory, *args)
      [memory[args[2]] = args[0..1].reduce(:*), shift_index_by]
    end

    def shift_index_by
      4
    end
  end

  class CopyInstruction < Instruction
    def call(memory, *args)
      [memory[args.first] = args[1], shift_index_by]
    end

    def shift_index_by
      2
    end
  end

  class OutputInstruction < Instruction
    def call(memory, *args)
      [puts("memory[#{args.first}] = #{memory[args.first]}"), shift_index_by]
    end

    def shift_index_by
      2
    end
  end

  class JumpIfTrueInstruction < Instruction
    def call(memory, *args)
      should_jump = !args.first.zero?
      updated_pointer = should_jump ? args[1] : shift_index_by
      [should_jump, updated_pointer]
    end

    def shift_index_by
      3
    end
  end

  class JumpIfFalseInstruction < Instruction
    def call(memory, *args)
      should_jump = args.first.zero?
      updated_pointer = should_jump ? args[1] : shift_index_by
      [should_jump, updated_pointer]
    end

    def shift_index_by
      3
    end
  end

  class LessThanInstruction < Instruction
    def call(memory, *args)
      memory[args[2]] = args[0] < args[1] ? 1 : 0
      [memory, shift_index_by]
    end

    def shift_index_by
      4
    end
  end

  class EqualsInstruction < Instruction
    def call(memory, *args)
      memory[args[2]] = args[0] == args[1] ? 1 : 0
      [memory, shift_index_by]
    end

    def shift_index_by
      4
    end
  end

  class HaltInstruction < Instruction
    def call(memory, *args)
      raise SignalHalt
    end

    def shift_index_by
      0
    end
  end

  class ParameterReader
    attr_reader :memory, :index
    def initialize(memory, index)
      @memory = memory
      @index = index
    end
  end

  class PositionParameterReader < ParameterReader
    def value
      memory[memory[index]]
    end
  end

  class ImmediateParameterReader < ParameterReader
    def value
      memory[index]
    end
  end

  INSTRUCTIONS = {
    1 => AdditionInstruction,
    2 => MultiplyInstruction,
    3 => CopyInstruction,
    4 => OutputInstruction,
    5 => JumpIfTrueInstruction,
    6 => JumpIfFalseInstruction,
    7 => LessThanInstruction,
    8 => EqualsInstruction,
    99 => HaltInstruction
  }.freeze

  class Solution
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def instrument(instruction_str)
      @memory = process_instruction_str(instruction_str)
      index   = 0
      loop do
        code        = @memory[index]
        #puts 'Operation'
        #puts "  index         : #{index}"
        #puts "  code          : #{code}"
        instruction = INSTRUCTIONS[code % 100].new
        params      = prepare_params(index, code, instruction, input)
        #puts "  instruction   : #{instruction.class}"
        #puts "  current_memory: #{@memory.to_s}"
        #puts "  params        : #{params.to_s}"
        result, shift_index_by = instruction.call(@memory, *params)
        if result && (instruction.is_a?(JumpIfTrueInstruction) || instruction.is_a?(JumpIfFalseInstruction))
          index = shift_index_by
        else
          index += shift_index_by
        end
        #puts "  updated index : #{index}"
        #puts ''
      end
    rescue SignalHalt
    end

    private

    def process_instruction_str(instruction_str)
      instruction_str.split(',').map(&:to_i)
    end

    def prepare_params(index, code, instruction, input)
      case instruction
      when AdditionInstruction, MultiplyInstruction, LessThanInstruction, EqualsInstruction
        [read_first_argument(index, code),
         read_second_argument(index, code),
         ImmediateParameterReader.new(@memory, index + 3).value]
      when JumpIfTrueInstruction, JumpIfFalseInstruction
        [read_first_argument(index, code), read_second_argument(index, code)]
      when CopyInstruction
        [ImmediateParameterReader.new(@memory, index + 1).value, input]
      when OutputInstruction
        [ImmediateParameterReader.new(@memory, index + 1).value]
      else
        []
      end
    end

    def read_first_argument(index, code)
      mode = code.digits[2] || 0
      if mode.zero?
        PositionParameterReader.new(@memory, index + 1).value
      else
        ImmediateParameterReader.new(@memory, index + 1).value
      end
    end

    def read_second_argument(index, code)
      mode = code.digits[3] || 0
      if mode.zero?
        PositionParameterReader.new(@memory, index + 2).value
      else
        ImmediateParameterReader.new(@memory, index + 2).value
      end
    end

    def read_third_argument(index, code)
      mode = code.digits[4] || 0
      if mode.zero?
        PositionParameterReader.new(@memory, index + 3).value
      else
        ImmediateParameterReader.new(@memory, index + 3).value
      end
    end
  end
end
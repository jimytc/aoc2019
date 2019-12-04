# frozen_string_literal: true

module Day4
  class Password
    attr_reader :raw

    VALID_RANGE = (111_111..999_999).freeze

    def initialize(raw)
      @raw = raw.to_i
    end

    def valid?
      validate_in_range &&
        validate_has_duplication &&
        validate_incremental_digits
    end

    private

    def validate_in_range
      VALID_RANGE.cover?(raw)
    end

    def validate_has_duplication
      raw.digits.each_cons(2).any? { |num1, num2| num1 == num2 }
    end

    def validate_incremental_digits
      raw.digits.each_cons(2).all? { |num1, num2| num2 <= num1 }
    end
  end

  class PasswordAdv < Password
    def valid?
      super &&
        validate_at_least_one_duplication_in_two
    end

    private

    def validate_at_least_one_duplication_in_two
      counts = raw.digits.reduce({}) do |h, number|
        h[number] ||= 0
        h[number] += 1
        h
      end
      counts.count { |_,c| c == 2 }.positive?
    end
  end

  class Solution
    attr_reader :start_number, :end_number

    def initialize(start_number, end_number)
      @start_number = start_number
      @end_number = end_number
    end

    def amount_of_valid_password
      (start_number..end_number).count { |password| Password.new(password).valid? }
    end

    def amount_of_valid_password_adv
      (start_number..end_number).count { |password| PasswordAdv.new(password).valid? }
    end
  end
end
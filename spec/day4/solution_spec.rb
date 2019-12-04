# frozen_string_literal: true

require 'Day4/solution'

describe Day4::Solution do
  context 'password is six digits' do
    it 'has no valid password for less than 100000' do
      solution = Day4::Solution.new(0, 99_999)
      expect(solution.amount_of_valid_password).to be(0)
    end

    it 'has no valid password for greater than 999999' do
      solution = Day4::Solution.new(1_000_000, 1_000_001)
      expect(solution.amount_of_valid_password).to be(0)
    end

    it 'has one valid password for 999_999' do
      solution = Day4::Solution.new(999_999, 1_000_000)
      expect(solution.amount_of_valid_password).to be(1)
    end

    it 'should have duplicate number' do
      solution = Day4::Solution.new(123_456, 123_456)
      expect(solution.amount_of_valid_password).to be(0)
    end

    it 'should have adjacent duplication' do
      solution = Day4::Solution.new(123_245, 123_245)
      expect(solution.amount_of_valid_password).to be(0)
    end

    it 'should be incremental' do
      solution = Day4::Solution.new(133_452, 133_452)
      expect(solution.amount_of_valid_password).to be(0)
    end
  end

  context 'provided test cases' do
    it 'has one valid password from 111_111 to 111_111' do
      solution = Day4::Solution.new(111_111, 111_111)
      expect(solution.amount_of_valid_password).to be(1)
    end

    it 'has no valid password from 223_450 to 223_450' do
      solution = Day4::Solution.new(223_450, 223_450)
      expect(solution.amount_of_valid_password).to be(0)
    end

    it 'has no valid password from 123_789 to 123_789' do
      solution = Day4::Solution.new(123_789, 123_789)
      expect(solution.amount_of_valid_password).to be(0)
    end
  end

  context 'calculate question' do
    it 'calculate aoc question from 108_457 to 562_041' do
      puts Day4::Solution.new(108_457, 562_041).amount_of_valid_password
    end
  end

  context 'advanced password validation' do
    it 'should check group of adjacent number' do
      solution = Day4::Solution.new(123_444, 123_444)
      expect(solution.amount_of_valid_password_adv).to be(0)
    end

    it 'should valid for 111_122' do
      solution = Day4::Solution.new(111_222, 111_222)
      expect(solution.amount_of_valid_password_adv).to be(0)
    end
  end

  context 'calculate adv question' do
    it 'calculate aoc question part2 from 108_457 to 562_041' do
      puts Day4::Solution.new(108_457, 562_041).amount_of_valid_password_adv
    end
  end
end

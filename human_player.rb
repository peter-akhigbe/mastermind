# frozen_string_literal: true

# Human Player Class
class HumanPlayer
  attr_reader(:guess, :name, :code)

  def initialize
    @name = 'Human'
  end

  def make_guess
    @guess = gets.chomp
  end

  def set_code
    puts "Please enter a 4-digit 'master code' for the computer to break."
    @code = gets.chomp.to_i
  end
end

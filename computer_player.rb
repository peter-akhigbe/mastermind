# frozen_string_literal: true

# Computer Player Class
class ComputerPlayer
  attr_reader(:guess, :name, :code)

  def initialize
    @name = 'Computer'
    @guess_array = [1, 1, 1, 1]
    @shuffle_array = []
  end

  def make_guess(feedback_array, turn)
    return @guess = 1111 if turn == 1

    if feedback_array.empty?
      @guess_array.map! { |value| value + 1 if value < 6 }
    elsif feedback_array.length.between?(1, 3)
      lent = feedback_array.length
      @guess_array.each_with_index { |value, index| (@guess_array[index] += 1 if value < 6) if index + 1 > lent }
    else
      @shuffle_array << @guess_array

      loop do
        array = @guess_array.shuffle

        if @shuffle_array.include?(array)
          next
        else
          @guess_array = array
          @shuffle_array << @guess_array
          break
        end
      end
    end

    @guess = @guess_array.join.to_i
  end

  def set_code
    @code = Array.new(4) { rand(1..6) }.join.to_i
    # puts @code
  end
end

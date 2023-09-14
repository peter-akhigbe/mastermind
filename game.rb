# frozen_string_literal: true

require_relative 'ansi_colors'
require_relative 'human_player'
require_relative 'computer_player'

# Game class
class Game
  include ANSIColors

  def initialize
    @turn_counter = 0
    @playing = true
  end

  def start_game
    puts "#{BOLD}#{UNDERLINE}It's time to play!#{RESET}"
    puts 'Would you like to be the code MAKER or code BREAKER?'
    puts
    puts "Press '1' to be the code MAKER"
    puts "Press '2' to be the code BREAKER"
    @game_mode = gets.chomp.to_i

    if @game_mode == 1
      @code_maker = HumanPlayer.new
      @code_breaker = ComputerPlayer.new
    elsif @game_mode == 2
      @code_maker = ComputerPlayer.new
      @code_breaker = HumanPlayer.new
    else
      puts "#{RED}Invalid Input#{RESET}"
    end

    @code_maker.set_code
    @secret_code = @code_maker.code

    loop do
      play_turn
      break unless @playing
    end
  end

  private

  def feedback
    @feedback_array = []
    code_array = @secret_code.to_s.split('')
    guess_array = @code_breaker.guess.to_s.split('')

    4.times do |index|
      if code_array[index] == guess_array[index]
        @feedback_array << 'A'
        code_array[index] = nil
        guess_array[index] = nil
      elsif code_array.include?(guess_array[index])
        @feedback_array << 'B'
        code_array[code_array.index(guess_array[index])] = nil
        guess_array[index] = nil
      end
    end
  end

  def play_turn
    puts "Turn ##{@turn_counter + 1}: Type in four numbers (1-6) to guess code, or 'q' to quit game."
    @code_breaker.make_guess(@feedback_array, @turn_counter + 1) if @code_breaker.instance_of?(ComputerPlayer)
    @code_breaker.make_guess if @code_breaker.instance_of?(HumanPlayer)
    feedback
    @turn_counter += 1
    puts "Guess: #{@code_breaker.guess} --- Clues: #{@feedback_array.sort.join}" unless @code_breaker.guess == 'q'
    check_game_over
  end

  def check_game_over
    if @secret_code == @code_breaker.guess.to_i
      puts "#{@secret_code} You broke the code! Congratulations, you win!"
      @playing = false
    end

    if @turn_counter == 12
      puts "#{RED}Game over. That was a hard code to break!#{RESET}"
      puts
      puts "Here is the 'master code' that you were trying to break: #{@secret_code}"
      @playing = false
    end

    @playing = false if @code_breaker.guess == 'q'
  end
end

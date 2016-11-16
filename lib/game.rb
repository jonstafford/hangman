require 'date'

class Game
  
  @@blank = "_"
  @@guesses_limit = 10
  
  def initialize word
    @word = word
    @bad_guesses = []
    @board = Array.new(word.length) { |index| @@blank }
    @started = DateTime.new
  end
  
  def wins?
    !@board.include? @@blank
  end
  
  def complete?
    @bad_guesses.length >= @@guesses_limit || wins?
  end
  
  # Answers string suitable for printing with the current state of the game
  def status
    str = []

    str[str.length] = ""
    str[str.length] = ""
    str[str.length] = ""
    
    if complete?
      str[str.length] = "Game completed.".upcase
      str[str.length] = 
      if wins?
        "You won!".upcase
      else
        "You lost.".upcase
      end
    else
      str[str.length] = "Try guessing a character in the hidden word."
      str[str.length] = "You have #{@@guesses_limit - @bad_guesses.length} remaining."
      
    end
    
    str[str.length] = ""
    str[str.length] = "Bad guesses: " + (@bad_guesses.join ", ")
    
    str[str.length] = ""
    str[str.length] = @board.join " "
    
    str.join("\n")
  end
  
  def play_move char
    if @bad_guesses.include? char
      # do nothing
    elsif !@word.match /#{char}/
      @bad_guesses << char
    else
      @word.chars.each_with_index do |c, index| 
        if c == char
         @board[index] = c
       end
     end 
    end
  end
  
end
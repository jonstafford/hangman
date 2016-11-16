# A player's move. They can ask to quit, save the game or just play a move
# which is one of the letters from A to Z.
class Move
  
  attr_reader :quit
  attr_reader :save
  attr_reader :char
  
  @quit = false
  @save = false
  
  def initialize char
    if char == "\u0003"
      @quit = true
    end

    if char =~ /[A-Z]/i  
      @char = char
    else
      @save = true
    end
  end
end
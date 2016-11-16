require 'io/console'
require_relative 'game'
require_relative 'move'

lines = File.open("5desk.txt", "r") { |file| file.readlines }

word = ""
while word.length < 5 || word.length > 12
  word = lines[rand(lines.length)].chomp # chomp to solve a line endings problem I had
end



def get_player_move
  char = STDIN.getch
  Move.new char
end

def save_game game
  puts "Saving game and exiting..."
  
  f = File.open("saves.dat", "a")
  f.puts Marshal.dump(game)
  f.close
  
  exit(0)
end


game = Game.new word

while !game.complete?
  puts game.status
  
  move = get_player_move
  
  if move.quit
    puts "Exiting without saving..."
    exit(1)
  elsif move.save
    save_game game
  else
    game.play_move move.char
  end
end

puts game.status
  
  


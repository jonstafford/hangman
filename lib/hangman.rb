require 'io/console'
require_relative 'game'
require_relative 'move'

SAVES_FILE_NAME = "saves.dat"

def get_player_move
  char = STDIN.getch
  Move.new char
end

def load_all_saved_games
  saved_games = []
  if File.exists? SAVES_FILE_NAME
    f = File.open(SAVES_FILE_NAME, "r")
    saved_games = Marshal.load(f)
  end
  
  saved_games
end

def save_all_games games
  f = File.open(SAVES_FILE_NAME, "w")
  f.print Marshal.dump(games)
  f.close
end

def save_game game_to_save
  puts "Saving game and exiting..."
  
  games = load_all_saved_games
  
  games << game_to_save
  
  save_all_games games
  
  exit(0)
end

def random_word
  lines = File.open("5desk.txt", "r") { |file| file.readlines }
  
  word = ""
  while word.length < 5 || word.length > 12
    word = lines[rand(lines.length)].chomp # chomp to solve a line endings problem I had
  end

  word
end

def get_game
  games = load_all_saved_games
  if !games.empty? 
    games.each_with_index do |game, index|
      puts "#{index+1}) #{game.started} #{game}"
    end
    
    puts "Choose number of saved game or type anything else or nothing to start a new game."
    choice = gets.chomp.to_i
    if (choice > 0 && choice <= games.length)
      index = choice - 1
      game_to_play = games[index]
      games.delete_at index
      save_all_games games
      return game_to_play
    end
  end
  
  Game.new random_word
end

game = get_game

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
  
  


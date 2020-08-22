require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"
require "./lib/card_generator"
class Game
  attr_reader :turn

  def initialize
    shuffled_deck = CardGenerator.new("lib/cards.txt").cards.shuffle
    deck1 = Deck.new(shuffled_deck[0..25])
    deck2 = Deck.new(shuffled_deck[26..51])

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    @turn = Turn.new(player1, player2)

    @turn_counter = 1
    @round_winner = ""
  end

  def start
    welcome_message
    until @turn_counter == 1000002
      puts " "
      game_type = @turn.type

      if game_type == :not_enough_cards || @turn.player1.has_lost? ||
        @turn.player2.has_lost?
        if @turn.player1.has_lost?
          puts "*~*~*~* #{@turn.player2.name} has won the game! *~*~*~*"
          break
        else
          puts "*~*~*~* #{@turn.player1.name} has won the game! *~*~*~*"
          break
        end
      end

      game_functionality
      game_type_bieng_played(game_type)
      @turn_counter += 1
      if @turn_counter == 1000001
        puts ""
        puts "---- DRAW ----"
        break
      end
    end
  end

  def welcome_message
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are Megan and Aurora."
    puts "Type 'GO' to start the game!"
    puts"------------------------------------------------------------------"
    player_input = gets.chomp.upcase
    while player_input != "GO" do
      puts "Invalid Input! type GO to start"
      player_input = gets.chomp.upcase
    end
  end

  def game_functionality
    @round_winner = @turn.winner
    @turn.pile_cards
    @turn.award_spoils(@round_winner)
  end

  def game_type_bieng_played(game_type)
    if game_type == :mutually_assured_destruction
      print "Turn #{@turn_counter}: *mutually assured destruction*"
      print " 6 cards removed from play"
    elsif game_type == :basic
      print "Turn #{@turn_counter}:"
      print " #{@round_winner.name} won #{@turn.spoils_of_war.length} cards"
    elsif game_type == :war
      print "Turn #{@turn_counter}: WAR"
      print "- #{@round_winner.name} won #{@turn.spoils_of_war.length} cards"
    end
  end
end

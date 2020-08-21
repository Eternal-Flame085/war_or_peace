require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"
class Game
  attr_reader :turn

  def initialize(turn)
    @turn = turn
    @turn_counter = 1
    @round_winner = ""
  end

  def start
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are Megan and Aurora."
    puts "Type 'GO' to start the game!"
    puts"------------------------------------------------------------------"
    player_input = "GO".upcase

    while player_input != "GO" do
      puts "Invalid Input! type GO to start"
      player_input = gets.chomp.upcase
    end

    until @turn_counter == 4002
      puts " "
      game_type = @turn.type
      if game_type == :no_war || @turn.player1.has_lost? || @turn.player2.has_lost?
        if @turn.player1.has_lost?
          puts "*~*~*~* #{@turn.player2.name} has won the game! *~*~*~*"
          break
        else
          puts "*~*~*~* #{@turn.player1.name} has won the game! *~*~*~*"
          break
        end
      end

      round_winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(round_winner)

      if @turn_counter == 4001
        puts "---- DRAW ----"
        break
      elsif game_type == :mutually_assured_destruction
        print "Turn #{@turn_counter}: *mutually assured destruction*"
        print "6 removed from play"
      elsif game_type == :basic
        print "Turn #{@turn_counter}:"
        print " #{round_winner.name} won #{@turn.spoils_of_war.length} cards"
      elsif game_type == :war
        print "Turn #{@turn_counter}: WAR"
        print "- #{round_winner.name} won #{@turn.spoils_of_war.length} cards"
      end
      @turn_counter += 1
    end
  end
end

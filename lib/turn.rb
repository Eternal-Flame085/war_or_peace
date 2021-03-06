class Turn
  attr_reader :player1, :player2, :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      :basic
    elsif @player1.deck.rank_of_card_at(2).nil? || @player2.deck.rank_of_card_at(2).nil?
      :not_enough_cards
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
      @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      :war
    end
  end

  def pile_cards
    @spoils_of_war.clear
    if type == :basic
      spoils_of_war_adding_basic_type_cards_and_delete_from_deck
    elsif type == :war
      spoils_of_war_adding_war_type_cards_and_delete_from_deck
      remove_3_cards_from_players
    elsif type == :mutually_assured_destruction
      remove_3_cards_from_players
    end
  end

  def spoils_of_war_adding_basic_type_cards_and_delete_from_deck
    @spoils_of_war << @player1.deck.cards[0]
    @spoils_of_war << @player2.deck.cards[0]
    player1.deck.remove_card
    player2.deck.remove_card
  end

  def spoils_of_war_adding_war_type_cards_and_delete_from_deck
    @spoils_of_war << @player1.deck.cards[0..2]
    @spoils_of_war << @player2.deck.cards[0..2]
    @spoils_of_war.flatten!
  end

  def remove_3_cards_from_players
    3.times do
      player1.deck.remove_card
      player2.deck.remove_card
    end
  end

  def award_spoils(winner)
    @spoils_of_war.shuffle.each {|card| winner.deck.add_card(card)}
  end

  def winner
    if type == :basic
      basic_war_winner
    elsif type == :war
      war_winner
    elsif type == :mutually_assured_destruction
      return "No Winner"
    end
  end

  def basic_war_winner
    if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      return @player1
    else
      return @player2
    end
  end

  def war_winner
    if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
      return @player1
    else
      return @player2
    end
  end
end

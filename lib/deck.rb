class Deck
  attr_reader :cards
  def initialize(cards)
    @cards = cards
    @high_ranking_cards = []
  end

  def high_ranking_cards
    @cards.find_all {|card| card.rank >= 11}
  end

  def rank_of_card_at(position)
    if position >= @cards.length
      return nil
    else
      @cards[position].rank
    end
  end

  def percent_high_cards
    ((high_ranking_cards.count / @cards.count.to_f) * 100).round(2)
  end

  def remove_card
    @cards.shift
  end

  def add_card(card)
    @cards << card
  end
end

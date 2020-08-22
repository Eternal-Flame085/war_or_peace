require_relative "card.rb"
class CardGenerator
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def cards
    card_array = []
    file = File.open(@filename)

    cards = file.readlines.map do |line|
      line.split(",").map(&:chomp)
    end

    cards.each do |card|
    card_array << Card.new(card[1].to_sym,card[0],card[2].to_i)
    end

    file.close
    return card_array
  end
end

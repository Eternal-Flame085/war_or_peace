require "./lib/game"
require "./lib/card_generator"

shuffled_deck = CardGenerator.new("lib/cards.txt").cards.shuffle

deck1 = Deck.new(shuffled_deck[0..25])
deck2 = Deck.new(shuffled_deck[26..51])

player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)

turn = Turn.new(player1, player2)

game = Game.new(turn)

game.start

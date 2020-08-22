
require "minitest/autorun"
require "minitest/pride"
require "./lib/card_generator"

class CradGeneratorTest < Minitest::Test

  def test_it_exists
    file_name = "cards.txt"
    card_generator = CardGenerator.new(file_name)

    assert_instance_of CardGenerator, card_generator
  end

end

# frozen_string_literal: true

module SolitaireCoder
  class Deck
    DECK_SIZE = 54

    attr_accessor :cards

    def initialize
      @cards = (1..52).to_a.push('A', 'B')
    end
  end
end

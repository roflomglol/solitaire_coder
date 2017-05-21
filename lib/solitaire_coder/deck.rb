# frozen_string_literal: true

module SolitaireCoder
  class Deck
    DECK_SIZE = 54

    attr_accessor :cards

    def initialize
      @cards = (1..52).to_a.push('A', 'B')
    end

    def move_a_card(card)
      current_index = cards.index(card)
      target_index  = current_index + 1
      target_index  = (target_index % DECK_SIZE) + 1 if target_index >= DECK_SIZE

      cards.insert(target_index, cards.delete_at(current_index))
    end

    def move_the_a_joker_down_one_card
      move_a_card('A')
    end
  end
end

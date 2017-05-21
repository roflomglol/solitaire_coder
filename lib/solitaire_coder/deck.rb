# frozen_string_literal: true

module SolitaireCoder
  class Deck
    DECK_SIZE = 54

    attr_accessor :cards

    def initialize
      @cards = (1..52).to_a.push('A', 'B')
    end

    def key
      move_the_a_joker_down_one_card
      move_the_b_joker_down_two_cards
      tripple_cut
      count_cut

      self
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

    def move_the_b_joker_down_two_cards
      2.times { move_a_card('B') }
    end

    def tripple_cut
      first_cut  = cards[last_joker_index + 1..cards.size - 1]
      second_cut = cards[first_joker_index..last_joker_index]
      third_cut  = cards[0...first_joker_index]

      self.cards = first_cut + second_cut + third_cut
    end

    def count_cut
      return if last_card_is_a_joker?

      last_card       = cards.last
      top_cut         = cards.shift(last_card)

      self.cards = cards.insert(cards.index(last_card), *top_cut)
    end

    private

    def first_joker_index
      cards.find_index { |card| card =~ /A|B/ }
    end

    def last_joker_index
      cards.rindex { |card| card =~ /A|B/ }
    end

    def last_card_is_a_joker?
      cards.last =~ /A|B/
    end
  end
end

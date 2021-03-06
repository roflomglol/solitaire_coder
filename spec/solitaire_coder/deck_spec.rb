# frozen_string_literal: true

RSpec.describe SolitaireCoder::Deck do
  let(:deck) { described_class.new }
  let(:default_cards_order) { (1..52).to_a.push('A', 'B') }

  describe '#move_a_card' do
    it 'moves a card one position down' do
      expect { deck.move_a_card('A') }.to change { deck.cards.last }.to('A')
    end

    context 'target card is at the bottom' do
      it 'moves a card just below the first one' do
        expect { deck.move_a_card('B') }.to change { deck.cards[1] }.to('B')
      end
    end
  end

  describe '#move_the_a_joker_down_one_card' do
    subject { deck.move_the_a_joker_down_one_card }

    it 'is expected to move the A joker down one card' do
      expect { subject }.to change { deck.cards.index('A') }.from(52).to(53)
    end
  end

  describe '#move_the_b_joker_down_two_cards' do
    subject { deck.move_the_b_joker_down_two_cards }

    it 'is expected to move the B joker down two cards' do
      expect { subject }.to change { deck.cards.index('B') }.from(53).to(2)
    end
  end

  describe '#tripple_cut' do
    it 'move cards from above the top joker below the second joker' do
      deck.cards = [1,'B', 2, 'A', 3]

      expect { deck.tripple_cut }.to change { deck.cards }.to([3, 'B', 2, 'A', 1])
    end

    context 'jokers are at the top and the bottom of the deck' do
      it 'does not change the deck' do
        deck.cards = ['A', 1, 2, 3, 'B']

        expect { deck.tripple_cut }.not_to change { deck.cards }
      end
    end
  end

  describe '#count_cut' do
    specify 'takes number of cards equal to value of last card, moves them just above the last card' do
      deck.cards = ['A', 1, 3, 'B', 2]

      expect { deck.count_cut }.to change { deck.cards }.to([3, 'B','A', 1, 2])
    end

    context 'jokers are at the top and the bottom of the dec' do
      it 'does not change the deck' do
        deck.cards = ['A', 1, 2, 3, 'B']

        expect { deck.count_cut }.not_to change { deck.cards }
      end
    end
  end

  describe '#key' do
    it 'keys the deck' do
      deck.cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'B']
      stub_const('SolitaireCoder::Deck::DECK_SIZE', deck.cards.size)

      expect { deck.key }.to change { deck.cards }.to([2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'B', 1])
    end
  end

  describe '#keystream_card', :focus do
    subject { deck.keystream_card }

    it 'gives a keystream card' do
      deck.cards = [1, 2, 'A', 'B', 3]

      expect(subject).to eq(2)
    end
  end
end

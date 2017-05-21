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
end

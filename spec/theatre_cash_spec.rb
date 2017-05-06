require_relative '../app/cashbox'
RSpec.describe Cinema::Theatre do
  let(:theatre) { Cinema::Theatre.new(File.expand_path('../../app/movies.txt', __FILE__)) }
  let(:theatre2) { Cinema::Theatre.new(File.expand_path('../../app/movies.txt', __FILE__)) }

  describe '#cash' do
    it 'when bay_ticket theatre2' do
      theatre2.buy_ticket 'Double Indemnity'
      theatre.buy_ticket 'The Lord of the Rings: The Return of the King'
      expect(theatre2.cash).to eq(3)
    end

    it 'when bay_ticket theatre2' do
      theatre.buy_ticket 'The Lord of the Rings: The Return of the King'
      theatre2.buy_ticket 'Double Indemnity'
      expect(theatre.cash).to eq(5)
    end
  end

  describe '#take' do
    it 'when theatre.take' do
      theatre.buy_ticket 'The Lord of the Rings: The Return of the King'
      theatre2.buy_ticket 'Double Indemnity'
      expect { theatre.take('Bank') }.to change(theatre, :cash).to(0)
    end

    it 'theatre.cash, when theatre2.take' do
      theatre2.buy_ticket 'The Lord of the Rings: The Return of the King'
      theatre.buy_ticket 'Double Indemnity'
      expect(theatre.cash).to eq(3)
    end
  end
end

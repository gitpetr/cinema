RSpec.describe Cinema::Netflix do
  let(:netflix) { Cinema::Netflix.new(File.expand_path('../../app/movies.txt', __FILE__)) }
  let(:netflix2) { Cinema::Netflix.new(File.expand_path('../../app/movies.txt', __FILE__)) }

  describe '#cash' do
    it 'when netflix' do
      netflix.pay(18)
      netflix2.pay(25)
      expect(netflix.class.cash).to eq(43)
    end

    it 'when netflix2' do
      expect(netflix2.class.cash).to eq(43)
    end

    it 'Netflix.cash' do
      expect { Cinema::Netflix.take('Bank') }.to change(netflix.class, :cash).by(-43)
    end
  end
end

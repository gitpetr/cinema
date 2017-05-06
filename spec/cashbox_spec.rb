require_relative '../app/cashbox'
RSpec.describe Cinema::CashBox::MovieCash do
  let(:netflix) { Object.new.extend(Cinema::CashBox::MovieCash) }
  before { netflix.addtocash 10 }
  describe '@cash' do
    context '#addtocash' do
      it 'when addtocash 10' do
        expect(netflix.addtocash(10)).to eq(20)
      end

      it 'changed by 20' do
        expect { netflix.addtocash 20 }.to change(netflix, :cash).by(20)
      end

      it 'changed to 40' do
        expect { netflix.addtocash 30 }.to change(netflix, :cash).to(40)
      end
    end

    context '#cash' do
      it 'when addtocash 10' do
        expect(netflix.cash).to eq(10)
      end
    end
  end

  describe '#take' do
    context 'when error' do
      it "when take 'banka'" do
        expect { netflix.take('banka') }.to raise_error(RuntimeError, 'Попытка взлома кассы. Вызвана полиция.')
      end
    end

    context 'when Bank' do
      it "when take 'Bank'" do
        netflix.take('Bank')
        expect(netflix.cash).to eq(0)
      end
    end

    context 'when Bank to nice' do
      it 'when change to 0' do
        expect { netflix.take('Bank') }.to change(netflix, :cash).to(0)
      end

      it 'when changed by -10' do
        expect { netflix.take('Bank') }.to change(netflix, :cash).by(-10)
      end
    end
  end
end

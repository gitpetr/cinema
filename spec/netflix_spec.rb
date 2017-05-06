RSpec.describe Cinema::Netflix do
  let(:netflix) { Cinema::Netflix.new(File.expand_path('../../app/movies.txt', __FILE__)) }
  before { netflix.pay(18) }
  describe '#show' do
    subject { netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern) }
    it {
      expect { subject }.to output(
        /Фильм:(.*)современное кино \( \d{4}, - \d{2,3} min\)\. Играют(.*)Оплата просмотра фильма(.*)на счете осталось \d{2}\.|d{2}\$$/
      ).to_stdout
    }
  end

  describe '#how_much?' do
    subject { netflix.how_much?('Gone Girl') }
    it {
      expect { subject }.to output(
        /Gone Girl - (.*) \d+ лет назад\. \( \d{4}, - \d{2,3} min\)\.  - просмотр фильма стоит  \d\.\d{2}\$,(.*)\d+\.\d{2}\$/
      )
        .to_stdout
    }
  end
end

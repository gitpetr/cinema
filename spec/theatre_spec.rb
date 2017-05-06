RSpec.describe Cinema::Theatre do
  let(:theatre) { Cinema::Theatre.new(File.expand_path('../../app/movies.txt', __FILE__)) }
  describe '#show' do
    context 'when right' do
      subject { theatre.show(13).each { |f| puts "\t #{f}" } }
      it { expect { subject }.to output(/(.*): (.*) \( \d{4}, (.*) - \d{2,3} min\)\./).to_stdout }
    end

    context 'when error' do
      subject { theatre.show(2).each { |f| puts "\t #{f}" } }
      it { expect { subject }.to raise_error(RuntimeError) }
    end
  end

  describe '#when' do
    subject { theatre.when? 'Double Indemnity' }
    it { expect { subject }.to output(/^(.*) - (.*) \( \d{4}, - \d{2,3} min\)\.  идут  c \d{1,2} по \d{1,2} $/).to_stdout }
  end
end

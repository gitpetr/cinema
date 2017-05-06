RSpec.describe Cinema::MovieCollection do
  let(:listfilms) { Cinema::MovieCollection.new(File.expand_path('../../app/movies.txt', __FILE__)) }

  describe '#all' do
    subject { listfilms.all }
    its(:count) { is_expected.to eq(250) }
    it { is_expected.to all be_a(Cinema::Movie) }
  end

  describe '#sortby' do
    subject { listfilms.sortby(:year).first }
    its(:year) { is_expected.to eq(1921) }
  end

  describe '#actors' do
    subject { listfilms.actors }
    its(:first) { is_expected.to be_a(Array) }
  end

  describe '#stats' do
    context 'по режиссерам' do
      subject { listfilms.stats(:director) }
      it { is_expected.to include('Zemeckis Robert' => 2) }
    end

    context 'по году' do
      subject { listfilms.stats(:year) }
      it { is_expected.to include(2010 => 7) }
    end

    context 'по актерам' do
      subject { listfilms.stats(:actors) }
      it { is_expected.to include('Al Pacino' => 5) }
    end

    context 'по незнакомому полю' do
      subject { listfilms.stats(:produsser) }
      it { expect { subject }.to raise_error(NoMethodError) }
    end

    context 'по месяцам' do
      subject { listfilms.stats(:month) }
      it { is_expected.to include('12' => 30) }
    end
  end

  describe '#filter' do
    subject do
      listfilms.filter(name: 'Oldboy',
                       year: 2003,
                       genre: /Drama/).first
    end
    # it { is_expected.to have_attributes( name: "Oldboy",
    #                             year: 2003,
    #                             genre: include('Drama')) }
    its(:name) { is_expected.to eq 'Oldboy' }
    its(:year) { is_expected.to eq 2003 }
    its(:genre) { is_expected.to include('Drama') }
  end
end

require 'spec_helper'

module Youtube
  describe KaraokeSearcher do
    describe '#search' do
      let(:song) { 'sugar marron 5' }

      it 'found song', :vcr do
        expect(subject.search(song).first.title).to eq('Maroon 5 - Sugar (Karaoke Version)')
      end
    end
  end
end

require 'spec_helper'

module Crawler::Billboard
  describe HotChart do
    let(:song) { subject.songs(limit: 1).first }

    context 'when found song' do
      it 'has expected title', :vcr do
        expect(song.title).to eq('Sorry')
      end

      it 'has expected author', :vcr do
        expect(song.author).to eq('Justin bieber')
      end
    end
  end
end

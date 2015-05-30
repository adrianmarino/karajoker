require 'spec_helper'

module Karajoker::Crawler
  describe BillboardHotSongsChart do
    let(:page) { Nokogiri::HTML(open('http://www.billboard.com/charts/hot-100')) }

    let(:song) { subject.songs(limit: 1).first }

    context '#songs' do
      context 'when found song' do
        it 'has expected title', :vcr do
          expect(song.title).to eq 'Bad blood'
        end

        it 'has expected author', :vcr do
          expect(song.author).to eq 'Taylor swift featuring kendrick lamar'
        end
      end
    end
  end
end

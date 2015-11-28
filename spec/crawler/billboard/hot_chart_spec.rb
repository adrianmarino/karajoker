require 'spec_helper'

module Crawler::Billboard
  describe HotChart do
    let(:page) { Nokogiri::HTML(open('http://www.billboard.com/charts/hot-100')) }
    let(:song) { subject.songs(limit: 1).first }

    context 'when found song' do
      it 'has expected title', :vcr do
        expect(song.title).to eq('Hello')
      end

      it 'has expected author', :vcr do
        expect(song.author).to eq('Adele')
      end
    end
  end
end

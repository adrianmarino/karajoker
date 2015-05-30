require 'spec_helper'

module Karajoker::Crawler::Official
  describe Chart do
    context '#songs' do
      context 'with rock-and-metal-singles chart on current date' do
        subject { Chart.select name: ROCK_AND_METAL_SINGLES, at: Date.parse('20140601') }

        let(:song) { subject.songs(limit: 1).first }

        it 'has expected title', :vcr do
          expect(song.title).to eq 'I wanna feel'
        end

        it 'has expected author', :vcr do
          expect(song.author).to eq 'Secondcity'
        end

        it 'has expected year', :vcr do
          expect(song.year).to eq 2015
        end
      end
    end
  end
end

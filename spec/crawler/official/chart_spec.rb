require 'spec_helper'

module Crawler::Official
  describe Chart do
    context '#songs' do
      context 'with rock-and-metal-singles chart on current date' do
        subject { described_class.select(name: ROCK_AND_METAL_SINGLES, at: '2014-06-01'.to_date) }

        let(:song) { subject.songs(limit: 1).first }

        it 'has expected title', :vcr do
          expect(song.title).to eq 'I wanna feel'
        end

        it 'has expected author', :vcr do
          expect(song.author).to eq 'Secondcity'
        end

        it 'has expected year', :vcr do
          expect(song.year).to eq 2014
        end
      end
    end
  end
end

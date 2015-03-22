require 'spec_helper'

describe Crawler::BillboardSongHotCharts do
  context "#songs" do
    it "found 2015 top 2 songs" do
      subject.songs(top: 2).each do |song|
        expect(song.author).not_to be_empty
        expect(song.title).not_to be_empty
      end
    end
  end
end

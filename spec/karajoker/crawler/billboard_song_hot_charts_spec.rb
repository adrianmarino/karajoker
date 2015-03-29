require 'spec_helper'

module Karajoker
  module Crawler
    describe BillboardSongHotCharts do
      context "#songs" do
        describe "when found 2015 top song" do
          it "has author" do
            expect(subject.songs(top: 1).first.author).not_to be_empty
          end
          it "has title" do
            expect(subject.songs(top: 1).first.title).not_to be_empty
          end
        end
      end
    end
  end
end

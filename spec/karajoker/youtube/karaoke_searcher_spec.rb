require 'spec_helper'

module Karajoker::Youtube
  describe KaraokeSearcher do
    describe "#search" do
      let(:song) { { query: "sugar marron 5" } }

      it "found song" do
        expect(subject.search(song).first.title).to include("Maroon 5 - Sugar (Karaoke Version)")
      end
    end
  end
end

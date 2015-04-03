require 'spec_helper'

module Karajoker::Youtube
  describe KaraokeSearcher do
    describe "#search" do
      let(:song) { { query: "Through Her Eyes dream theater" } }

      it "found song" do
        expect(subject.search(song).first.title).to include("Through Her Eyes")
      end
    end
  end
end

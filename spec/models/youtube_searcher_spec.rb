require 'spec_helper'

describe Youtube::KaraokeSearcher do
  describe "#search" do
    let(:song) { { query: "Through Her Eyes dream theater" } }

    it "found song" do
      results = subject.search(song)
      expect(results.first.title).to include("Through Her Eyes")
    end
  end
end

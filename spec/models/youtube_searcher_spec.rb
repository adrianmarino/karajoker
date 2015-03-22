require 'spec_helper'

describe Youtube::KaraokeSearcher do
  describe "#search" do
    let(:song) { { title: "Through Her Eyes", author: "dream theater" } }
    let(:song_result) do
      Youtube::KaraokeResult.new "Dream Theater - Through Her Eyes (Karaoke Version)"
    end

    it "found song" do
      expect(subject.search(song)).include(song_result)
    end
  end
end

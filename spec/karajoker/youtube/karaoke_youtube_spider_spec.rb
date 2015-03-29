module Karajoker
  module Youtube
    describe KaraokeYoutubeSpider do
      describe "#start" do
        let(:song) { Song.new("Through Her Eyes", "Dream theater") }

        it "index new video" do
          expect { subject.start([song]) }.to change(Karaoke, :count).by(1)
        end

        describe "when index pre-existent video" do
          before { subject.start([song]) }
          it "not save new karaoke" do
            expect { subject.start([song]) }.to change(Karaoke, :count).by(0)
          end
        end
      end
    end
  end
end

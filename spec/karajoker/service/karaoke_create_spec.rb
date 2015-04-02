module Karajoker
  module Service
    describe KaraokeCreate do
      describe "#call" do
        let(:song) { Song.new("Through Her Eyes", "Dream theater") }

        it "index new video" do
          expect { subject.call([song]) }.to change(Karaoke, :count).by(1)
        end

        describe "when index pre-existent video" do
          before { subject.call([song]) }
          it "not save new karaoke" do
            expect { subject.call([song]) }.to change(Karaoke, :count).by(0)
          end
        end
      end
    end
  end
end

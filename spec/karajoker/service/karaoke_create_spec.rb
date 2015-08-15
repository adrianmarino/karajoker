Song = Karajoker::Entity::Song
Karaoke = Karajoker::Entity::Karaoke

module Karajoker::Service
  describe KaraokeCreate do
    describe '#call' do
      let(:song) { Song.new(2005, 'Through Her Eyes', 'Dream theater') }

      it 'index new video', :vcr do
        expect { subject.call([song]) }.to change(Karaoke, :count).by(1)
      end

      describe 'when index pre-existent video' do
        before { subject.call([song]) }
        it 'not save new karaoke', :vcr do
          expect { subject.call([song]) }.to change(Karaoke, :count).by(0)
        end
      end
    end
  end
end

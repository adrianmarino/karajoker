module Service
  describe KaraokeCreate do
    describe '#call' do
      let(:song) { Song.new(2005, 'With Or Without You', 'U2') }

      it 'index new video', :vcr do
        expect { subject.call(song) }.to change(Karaoke, :count).by(1)
      end

      describe 'when index pre-existent video' do
        before { subject.call(song) }
        it 'not save new karaoke', :vcr do
          expect { subject.call(song) }.to change(Karaoke, :count).by(0)
        end
      end
    end
  end
end

Song = Karajoker::Entity::Song

module Karajoker::Service
  describe SongSearch do
    describe '#call' do
      context 'when search songs at 2014', :vcr do
        before { stub_const('Karajoker::Crawler::Official::Chart::ALL', %w(singles)) }

        it 'returns songs as 2014' do
          expect(subject.call(2014, 2).songs.map(&:year).uniq.first).to eq(2014)
        end
      end
    end
  end
end

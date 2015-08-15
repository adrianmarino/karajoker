module Karajoker::Service
  describe SongSearch do
    Song = Karajoker::Entity::Song

    let(:service_call) { subject.call(attributes) }

    describe '#call' do
      context 'when search songs at 2014', :vcr do
        let(:attributes) { { year: 2014, limit: 2 } }

        it 'returns songs as 2014' do
          expect(service_call).to satisfy -> (s) { s.year == 2014 }
        end
      end
    end
  end
end

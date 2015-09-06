require 'spec_helper'

module Rest::Resource
  describe KaraokeResource do
    include RestTestUtils

    describe 'POST' do
      describe 'when add a hello karaoke tag as pop' do
        let(:karaoke_params)  { { title: 'hello', youtube_id: '1234', tags: [:pop] } }
        let(:send_karaoke)    { http_post karaoke_params }
        before do
          create(:tag, :pop)
          http_post karaoke_params
        end

        it 'has same title' do
          expect(Karaoke.first.title).to eq karaoke_params[:title]
        end

        it 'has same tag' do
          expect(Karaoke.first.tags.first.name.downcase).to eq karaoke_params[:tags].first.to_s
        end

        it 'has same youtube_id' do
          expect(Karaoke.first.youtube_id).to eq karaoke_params[:youtube_id]
        end
      end
    end

    describe 'GET' do
      before do
        create :karaoke, :hello_1
        create :karaoke, :hello_2
      end

      describe 'when list all karaokes' do
        it 'get karaokes' do
          http_get
          compare response_boby, Karaoke.all
        end
      end

      describe 'when find karaoke hello_1' do
        it 'found karaoke' do
          http_get "/search/#{Karaoke.first.title}"
          compare response_boby, [Karaoke.first]
        end
      end
    end

    describe 'DELETE' do
      describe 'remove karaoke hello_1' do
        let(:video) { create :karaoke, :hello_1 }

        it 'karaoke was removed from db' do
          http_delete video.id
          expect(Karaoke.all.empty?).to eq true
        end
      end
    end

    protected

    def url
      :karaokes
    end

    private

    def compare(results, karaokes)
      results.zip(karaokes).each do |result, karaoke|
        expect(result.title).to eq(karaoke.title)
        expect(result.author).to eq(karaoke.author)
        expect(result.year).to eq(karaoke.year)
        expect(result.id).to eq(karaoke.youtube_id)
      end
    end
  end
end

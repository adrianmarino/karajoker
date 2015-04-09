require 'spec_helper'

module Karajoker::Rest::Resource
  describe KaraokeResource do
    include RestTestUtils
    Karaoke = Karajoker::Entity::Karaoke

    describe "'POST'" do
      describe "when add a hello karaoke tag as pop" do
        let(:karaoke_params)  { { title: 'hello', youtube_id: '1234', tags: [:pop] } }
        let(:send_karaoke)    { http_post karaoke_params }
        before                { create(:tag, :pop) }

        it "respond http 201" do
          send_karaoke
          expect_201_http
        end

        it "has same title" do
          http_post karaoke_params
          expect(Karaoke.first.title).to eq karaoke_params[:title]
        end

        it "has same tag" do
          http_post karaoke_params
          expect(Karaoke.first.tags.first.name.downcase).to eq karaoke_params[:tags].first.to_s
        end

        it "has same youtube_id" do
          http_post karaoke_params
          expect(Karaoke.first.youtube_id).to eq karaoke_params[:youtube_id]
        end
      end
    end

    describe "'GET'" do
      before do
        create :karaoke, :hello_1
        create :karaoke, :hello_2
      end

      describe "when list all karaokes" do
        it "respond http 200" do
          http_get
          expect_200_http
        end

        it "get karaokes" do
          http_get
          compare response_boby, Karaoke.all
        end
      end

      describe "when find karaoke hello_1" do
        self.use_transactional_fixtures = false

        after { Karaoke.delete_all }

        it "respond http 200" do
          http_get "/search/#{Karaoke.first.title}"
          expect_200_http
        end

        it "fond karaoke" do
          http_get "/search/#{Karaoke.first.title}"
          expect(response_boby).to_not be_empty
        end

        it "found karaoke with data" do
          http_get "/search/#{Karaoke.first.title}"
          compare response_boby, [Karaoke.first]
        end
      end
    end

    describe "'DELETE'" do
      describe "remove karaoke hello_1" do
        let(:video) { create :karaoke, :hello_1 }

        it "respond http 200" do
          http_delete video.id
          expect_200_http
        end

        it "karaoke was removed from db" do
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
      results.zip(karaokes).each do |item|
        result = item.first
        karaoke = item.second
        expect(result.title).to eq(karaoke.title)
        expect(result.author).to eq(karaoke.author)
        expect(result.year).to eq(karaoke.year)
        expect(result.id).to eq(karaoke.youtube_id)
      end
    end

  end
end

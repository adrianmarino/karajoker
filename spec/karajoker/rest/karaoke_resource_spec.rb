require 'spec_helper'

module Karajoker
  module Rest
    describe KaraokeResource do
      include RestTestUtils

      describe "'POST'" do
        describe "when add a hello karaoke tag as pop" do

          let(:karaoke_params) { { title: 'hello', youtube_id: '1234', tags: [:pop] } }
          let(:send_karaoke) { http_post karaoke_params }

          before { create(:tag, :pop) }

          it "respond http 201" do
            send_karaoke
            expect_201_http
          end

          it "has same title" do
            http_post karaoke_params
            expect(Karaoke.first.title).to eq karaoke_params[:title]
          end

          it "has same youtube_id" do
            http_post karaoke_params
            expect(Karaoke.first.youtube_id).to eq karaoke_params[:youtube_id]
            expect(Karaoke.first.tags.first.name.downcase).to eq karaoke_params[:tags].first.to_s
          end
        end
      end

      describe "'GET'" do
        let!(:videos) { [create(:karaoke, :hello_1), create(:karaoke, :hello_2)] }
        before { videos }

        describe "when list all karaokes" do
          it "respond http 200" do
            http_get
            expect_200_http
          end

          it "get karaokes" do
            http_get
            results = response_boby
            expect(results.first.title).to eq videos.first.title
            expect(results.second.title).to eq videos.second.title
          end
        end

        describe "when find karaoke hello_1" do
          it "respond http 200" do
            http_get "/search/#{videos.first.title}"
            expect_200_http
          end

          it "karaoke found" do
            http_get "/search/#{videos.first.title}"
            expect(response_boby.first.title).to eq videos.first.title
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

    end
  end
end

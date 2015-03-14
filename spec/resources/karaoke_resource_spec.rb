require 'spec_helper'

describe  Karajoker::Rest::KaraokeResource do
    include RestTestUtils

    # -------------------------------------------------------------------------
    # Test Methods
    # -------------------------------------------------------------------------

    it "add a hello karaoke tag as pop" do
        # Prepare
        karaoke = { title: 'hello', youtube_id: '1234', tags: [:pop] }
        tag = FactoryGirl.create(:tag, :pop)

        # Perform
        http_post karaoke

        # Assert
        expect(response.status).to eq 201
        expect(Karaoke.first.title).to eq karaoke[:title]
        expect(Karaoke.first.youtube_id).to eq karaoke[:youtube_id]
        expect(Karaoke.first.tags.first.name).to eq tag.name
    end

    it "list all karaokes" do
        # Prepare
        videos = [FactoryGirl.create(:karaoke, :hello_1), FactoryGirl.create(:karaoke, :hello_2)]

        # Perform
        http_get

        # Asserts
        results = response_boby
        expect(response.status).to eq 200
        expect(results.first.title).to eq videos.first.title
        expect(results.second.title).to eq videos.second.title
    end

    it "find karaoke hello_1" do
        # Prepare
        videos = [FactoryGirl.create(:karaoke, :hello_1), FactoryGirl.create(:karaoke, :hello_2)]

        # Perform
        http_get "/search/#{videos.first.title}"

        # Asserts
        results = response_boby
        expect(response.status).to eq 200
        expect(results.first.title).to eq videos.first.title
    end

    it "remove karaoke hello_1" do
        # Prepare
        video = create :karaoke, :hello_1

        # Perform
        http_delete video.id

        # Asserts
        expect(response.status).to eq 200
        expect(Karaoke.all.empty?).to eq true
    end

    # -------------------------------------------------------------------------
    # Protected Methods
    # -------------------------------------------------------------------------
    protected

    def url
        :karaokes
    end

end

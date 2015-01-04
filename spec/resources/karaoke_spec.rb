require 'rails_helper'

describe Resource::KaraokeResource do
    include FactoryGirl

    # -------------------------------------------------------------------------
    # Test Methods
    # -------------------------------------------------------------------------

    it "add a hello karaoke" do
        # Prepare
        karaoke = { title: 'hello', youtube_id: '1234' }.to_json

        # Perform
        karaokes_post karaoke

        # Asserts
        expect(response.status).to eq 201
        expect(Karaoke.first.title).to eq "hello"
        expect(Karaoke.first.youtube_id).to eq "1234"
    end

    it "list all karaokes" do
        # Prepare
        videos = [create(:karaoke, :hello_1), create(:karaoke, :hello_2)]

        # Perform
        get URL

        # Asserts
        results = response_boby
        expect(response.status).to eq 200
        expect(results.first.title).to eq videos.first.title
        expect(results.second.title).to eq videos.second.title
    end

    it "remove karaoke hello_1" do
        # Prepare
        video = create :karaoke, :hello_1

        # Perform
        delete "#{URL}/#{video.id}"

        # Asserts
        expect(response.status).to eq 200
        expect(Karaoke.all.empty?).to eq true        
    end


    # -------------------------------------------------------------------------
    # Private Methods
    # -------------------------------------------------------------------------
    private
    def karaokes_post(a_body)
        post URL, a_body, JSON_HEADERS
    end

    def response_boby
        JSON.parse(response.body).collect {|an_item| OpenStruct.new an_item}
    end

    # -------------------------------------------------------------------------
    # Constants
    # -------------------------------------------------------------------------

    URL = 'api/karaokes'

    JSON_HEADERS = { "Accept" => "application/json", "Content-Type" => "application/json" }
end
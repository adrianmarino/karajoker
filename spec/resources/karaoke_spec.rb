require 'rails_helper'

describe "Resource:Karaoke" do
    it "Add a karaoke" do
        # Prepare
        karaoke = { title: 'hello', youtube_id: '1234' }.to_json
        headers = { "Accept" => "application/json", "Content-Type" => "application/json" }

        # Perform
        post "api/karaokes", karaoke, headers

        # Asserts
        expect(response.status).to eq 201 # created
        expect(Karaoke.first.title).to eq "hello"
        expect(Karaoke.first.youtube_id).to eq "1234"
    end
end
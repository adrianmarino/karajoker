require 'rails_helper'

describe Resource::TagResource do
    include RestTestUtils

    # -------------------------------------------------------------------------
    # Test Methods
    # -------------------------------------------------------------------------

    it "add a pop tag" do
        # Prepare
        tag = { name: 'Pop'}

        # Perform
        http_post tag

        # Asserts
        expect(response.status).to eq 201
        expect(Tag.first.name).to eq tag[:name]
    end

    it "list all tags" do
        # Prepare
        tags = [FactoryGirl.create(:tag, :pop), FactoryGirl.create(:tag, :rock)]

        # Perform
        http_get

        # Asserts
        results = response_boby
        expect(response.status).to eq 200
        expect(results.first.name).to eq tags.first.name
        expect(results.second.name).to eq tags.second.name
    end

    # -------------------------------------------------------------------------
    # Protected Methods
    # -------------------------------------------------------------------------
    protected
    def url
        :tags
    end

end

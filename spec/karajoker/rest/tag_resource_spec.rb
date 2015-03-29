require 'spec_helper'

module Karajoker
  module Rest
    describe TagResource do
      include RestTestUtils

      # -------------------------------------------------------------------------
      # Test Methods
      # -------------------------------------------------------------------------

      describe "'POST'" do
        describe "add a pop tag" do
          let(:tag) { { name: 'Pop'} }

          it "respond http 201" do
            http_post tag
            expect_201_http
          end

          it "was saved" do
            http_post tag
            expect(Tag.first.name).to eq tag[:name]
          end
        end
      end

      describe "'GET'" do
        describe "list all tags" do
          let(:tags) { [create(:tag, :pop), create(:tag, :rock)] }

          it "response http 200" do
            http_get
            expect_200_http
          end

          it "get tags" do
            http_get
            response_boby.each_with_index do |result, index|
              expect(result.name).to eq tag[index].name
            end
          end
        end
      end

      # -------------------------------------------------------------------------
      # Protected Methods
      # -------------------------------------------------------------------------
      protected

      def url
        :tags
      end

    end
  end
end

require 'spec_helper'

module Rest::Resource
  describe TagResource do
    include RestTestUtils

    describe 'POST' do
      describe 'add a pop tag' do
        let(:tag) { { name: 'Pop' } }

        it 'was saved' do
          http_post tag
          expect(Tag.first.name).to eq tag[:name]
        end
      end
    end

    describe 'GET' do
      describe 'list all tags' do
        let(:tags) { [create(:tag, :pop), create(:tag, :rock)] }

        it 'get tags' do
          http_get
          response_boby.each_with_index do |result, index|
            expect(result.name).to eq tag[index].name
          end
        end
      end
    end

    protected

    def url
      :tags
    end
  end
end

require 'spec_helper'

module Karajoker::Crawler
  describe BillboardHotSongsChart do
    let(:page) { Nokogiri::HTML(open("http://www.billboard.com/charts/hot-100")) }

    context "#songs" do
      context "when found song" do
        it "has author", :vcr do
          expect(subject.songs(limit: 1).first.author).not_to be_empty
        end

        it "has title", :vcr do
          expect(subject.songs(limit: 1).first.title).not_to be_empty
        end

        it "has expected title", :vcr do
          subject.songs(limit: 1).zip(songs 1) do |result, expected|
            expect(result.title).to eq expected.title
          end
        end

        it "has expected author", :vcr do
          subject.songs(limit: 1).zip(songs 1) do |result, expected|
            expect(result.author).to eq expected.author
          end
        end
      end
    end

    def songs(limit)
      counter = 0
      (page.css('div[class=row-title]').inject([]) do | songs, an_item |
         title = an_item.children.css('h2').children.to_s.strip.humanize
         author = an_item.children.css('h3').css('a').children.to_s.strip.humanize
         counter +=1
         songs << OpenStruct.new(order: counter, title: title, author: author)
      end).take limit
    end
  end
end

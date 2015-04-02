require 'spec_helper'

module Karajoker
  module Crawler
    describe BillboardSongHotCharts do
      context "#songs" do
        context "when found 2015 top song" do
          it "has author" do
            expect(subject.songs(top: 1).first.author).not_to be_empty
          end

          it "has title" do
            expect(subject.songs(top: 1).first.title).not_to be_empty
          end

          it "has results with correct title and author fields" do
            subject.songs(top: 1).zip(search 1) do |result, expected|
              expect(result.title).to eq expected.title
              expect(result.author).to eq expected.author
            end
          end
        end
      end

      def search(top)
        counter = 0
        (page.css('div[class=row-title]').inject([]) do | songs, an_item |
           title = an_item.children.css('h2').children.to_s.strip
           author = an_item.children.css('h3').css('a').children.to_s.strip
           counter +=1
           songs << OpenStruct.new(order: counter, title: title, author: author)
        end).take top
      end

      def page
        Nokogiri::HTML(open("http://www.billboard.com/charts/hot-100"))
      end

    end
  end
end

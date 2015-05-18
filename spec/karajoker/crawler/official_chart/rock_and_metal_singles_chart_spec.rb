require 'spec_helper'

module Karajoker::Crawler::OfficialChart
  describe RockAndMetalSinglesChart do
    let(:page) { Nokogiri::HTML(open("http://www.officialcharts.com/charts/rock-and-metal-singles-chart")) }

    context "#songs" do
      context "when found song" do
        it "has author" do
          expect(subject.songs(top: 1).first.author).not_to be_empty
        end

        it "has title" do
          expect(subject.songs(top: 1).first.title).not_to be_empty
        end

        it "has expected title" do
          subject.songs(top: 1).zip(songs 1) do |result, expected|
            expect(result.title).to eq expected.title
          end
        end

        it "has expected author" do
          subject.songs(top: 1).zip(songs 1) do |result, expected|
            expect(result.author).to eq expected.author
          end
        end

        it "has expected year" do
          subject.songs(top: 1).zip(songs 1) do |result, expected|
            expect(result.year).to eq Date.current.year
          end
        end
      end
    end

    def songs(top)
      counter = 0
      (page.css('div[class=title-artist]').inject([]) do | songs, an_item |
         title = an_item.children.css('a').first.text.strip.humanize
         author = an_item.children.css('div[class=artist]').css('a').first.text.strip.humanize
         counter +=1
         songs << OpenStruct.new(order: counter, title: title, author: author)
      end).take top
    end
  end
end

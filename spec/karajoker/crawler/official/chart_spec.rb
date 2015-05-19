require 'spec_helper'

module Karajoker::Crawler::Official
  describe Chart do
    context "#songs" do
      context "with rock-and-metal-singles chart on current date" do
        subject { Chart.select name: ROCK_AND_METAL_SINGLES, at: Date.parse('20140601') }

        let(:songs) { chart(limit:1, name: 'rock-and-metal-singles-chart', date: Date.parse('20140601')) }

        it "has author" do
          expect(subject.songs(limit: 1).first.author).not_to be_empty
        end

        it "has title" do
          expect(subject.songs(limit: 1).first.title).not_to be_empty
        end

        it "has expected title" do
          subject.songs(limit: 1).zip(songs) do |result, expected|
            expect(result.title).to eq expected.title
          end
        end

        it "has expected author" do
          subject.songs(limit: 1).zip(songs) do |result, expected|
            expect(result.author).to eq expected.author
          end
        end

        it "has expected year" do
          subject.songs(limit: 1).zip(songs) do |result, expected|
            expect(result.year).to eq Date.current.year
          end
        end
      end
    end

    def chart(limit:, name:, date:)
      page = Nokogiri::HTML(open("http://www.officialcharts.com/charts/#{name}/#{date.strftime('%Y%m%d')}"))
      counter = 0
      (page.css('div[class=title-artist]').inject([]) do | songs, an_item |
         title = an_item.children.css('a').first.text.strip.humanize
         author = an_item.children.css('div[class=artist]').css('a').first.text.strip.humanize
         counter +=1
         songs << OpenStruct.new(order: counter, title: title, author: author)
      end).take limit
    end
  end
end

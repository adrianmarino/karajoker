require 'rails_helper'

describe SongCrawler do

    # -------------------------------------------------------------------------
    # Test Methods
    # -------------------------------------------------------------------------

    it "Search top 2 songs of 2015" do
        # Prepare
        crawler = SongCrawler.new

        # Perform
        results = crawler.serch top: 2

        # Assert
        expect_song results, 0, 'Uptown Funk!', 'Mark Ronson Featuring Bruno Mars'
        expect_song results, 1, 'Thinking Out Loud', 'Ed Sheeran'
    end

    # -------------------------------------------------------------------------
    # Private Methods
    # -------------------------------------------------------------------------

    private
    def expect_song(results, order,title, author)
        expect(results[order][:title]).to eq title
        expect(results[order][:author]).to eq author
    end

end

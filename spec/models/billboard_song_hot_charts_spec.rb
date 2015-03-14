require 'spec_helper'

describe Crawler::BillboardSongHotCharts do

    # -------------------------------------------------------------------------
    # Test Methods
    # -------------------------------------------------------------------------

    it "Search 2015 top 2 songs" do
        # Prepare
        page = Crawler::BillboardSongHotCharts.new

        # Perform
        songs = page.songs top: 2

        # Assert
        expect_song songs, 0, 'Uptown Funk!', 'Mark Ronson Featuring Bruno Mars'
        expect_song songs, 1, 'Thinking Out Loud', 'Ed Sheeran'
    end

    # -------------------------------------------------------------------------
    # Private Methods
    # -------------------------------------------------------------------------
    private

    def expect_song(songs, order,title, author)
        expect(songs[order].title).to eq title
        expect(songs[order].author).to eq author
    end

end

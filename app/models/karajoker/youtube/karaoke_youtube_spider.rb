module Karajoker
  module Youtube
    class KaraokeYoutubeSpider

      def start(songs)
         karaokes_from(songs).each {|karaoke| create karaoke }
      end

      private

      def karaokes_from(songs)
        songs.map { |song| search(song).first }
      end

      def search(song)
        KaraokeSearcher.new.search(query_from(song))
      end

      def query_from(song)
        { query: "#{song.title} #{song.author}" }
      end

      def create(karaoke)
        Karaoke.create_from title: karaoke.title, youtube_id: karaoke.id
      end
    end
  end
end

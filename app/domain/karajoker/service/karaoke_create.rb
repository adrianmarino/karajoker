module Karajoker::Service
  class KaraokeCreate
    KaraokeSearcher = Karajoker::Youtube::KaraokeSearcher
    Karaoke = Karajoker::Entity::Karaoke
    Logger = Rails.logger

    def call(songs)
      karaokes = filter_news(karaokes_from(songs))
      karaokes.each {|karaoke| create karaoke }
      karaokes.size
    end

    private
    def filter_news(karaokes)
      karaokes.reject do |karaoke|
        if already_exist?(karaoke)
          Logger.info "Karaoke Already Exist! (#{karaoke})"
          true
        else
          false
        end
      end
    end

    def already_exist?(karaoke)
      Karaoke.exists? youtube_id: karaoke.id
    end

    def karaokes_from(songs)
      songs.map do |song|
        karaoke = search(song).first
        Logger.info "Search: #{song}, Founded: '#{karaoke}'" unless karaoke.nil?
        karaoke
      end
    end

    def search(song)
      KaraokeSearcher.new.search(query_from(song))
    end

    def query_from(song)
      { query: "#{song.title} #{song.author}" }
    end

    def create(karaoke)
      Logger.info "Index: '#{karaoke}'"
      Karaoke.create_from title: karaoke.title, youtube_id: karaoke.id
    end
  end
end

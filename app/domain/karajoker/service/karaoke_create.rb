module Karajoker::Service
  class KaraokeCreate
    KaraokeSearcher = Karajoker::Youtube::KaraokeSearcher
    Karaoke = Karajoker::Entity::Karaoke
    Logger = Rails.logger

    def call(songs)
      count = 0
      ActiveRecord::Base.transaction do
        karaokes = songs.map do |song|
          karaoke = search(song)

          if already_exist?(karaoke)
            Logger.info "\t- Already Indexed!"
          else
            create song, karaoke
            count += 1
          end
        end
      end
      count
    end

    private

    def already_exist?(karaoke)
      Karaoke.exists? youtube_id: karaoke.id
    end

    def search(song)
      Logger.info "Youtube Search: #{song}"
      karaoke = KaraokeSearcher.new.search(query_from(song)).first
      Logger.info "\t- Founded!" unless karaoke.nil?
      karaoke
    end

    def query_from(song)
      { query: "#{song.title} #{song.author}" }
    end

    def create(song, karaoke)
      Logger.info "\t- Index!"
      Karaoke.create_from author: song.author, title: song.title, youtube_id: karaoke.id
    end
  end
end

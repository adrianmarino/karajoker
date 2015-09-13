module Service
  class SongSearchResponse < ServiceResponse
    attr_reader :songs

    def initialize(songs, success = true, errors = [])
      super(success, errors)
      @songs = songs
    end
  end
end

require 'grape'

module Karajoker::Rest::Entity
  class KaraokeDetail < Grape::Entity
    TagDetail = Karajoker::Rest::Entity::TagDetail

    expose :youtube_id, documentation: { type: 'string', desc: 'The id of youtube id' }, as: :id
    expose :title, documentation: { type: 'string', desc: 'The title of song' }
    expose :author, documentation: { type: 'string', desc: 'The author of song' }
    expose :year, documentation: { type: 'string', desc: 'The born year of song' }
    expose :tags, using: TagDetail, as: :tags
  end
end

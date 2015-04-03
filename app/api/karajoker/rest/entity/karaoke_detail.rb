require 'grape'

module Karajoker::Rest::Entity
  class KaraokeDetail < Grape::Entity
    TagDetail = Karajoker::Rest::Entity::TagDetail

    expose :title, :documentation => {:type => "string", :desc => "The title of karaoke"}
    expose :tags, using: TagDetail, as: :tags
  end
end

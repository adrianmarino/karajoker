require 'grape'

module Entities
  class TagDetail < Grape::Entity
    expose :name, :documentation => {:type => "string", :desc => "The name of tag"}
  end
  class KaraokeDetail < Grape::Entity
    expose :title, :documentation => {:type => "string", :desc => "The title of karaoke"}
    expose :tags, using: TagDetail, as: :tags
  end
end
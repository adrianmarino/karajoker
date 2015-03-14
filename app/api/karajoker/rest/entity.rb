require 'grape'

module Karajoker
    module Rest
        module Entity
            class TagDetail < Grape::Entity
                expose :name, :documentation => {:type => "string", :desc => "The name of tag"}
            end
            class KaraokeDetail < Grape::Entity
                expose :title, :documentation => {:type => "string", :desc => "The title of karaoke"}
                expose :tags, using: Karajoker::Rest::Entity::TagDetail, as: :tags
            end
        end
    end
end

module Karajoker::Entity
  class Karaoke < ActiveRecord::Base

    # -------------------------------------------------------------------------
    # Class Methods
    # -------------------------------------------------------------------------

    def self.search(a_query)
      # raise 'Aan example error!'
      self.includes(:tags).where("title LIKE ? ", "%#{a_query}%")
    end

    def self.create_from(params)
      create(
        author: params[:author],
        title: params[:title],
        youtube_id: params[:youtube_id],
        tags: Tag.find_by_names(params[:tags])
      )
    end

    # -------------------------------------------------------------------------
    # Associations...
    # -------------------------------------------------------------------------

    has_and_belongs_to_many :tags

  end
end

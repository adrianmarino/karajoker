module Karajoker::Entity
  class Karaoke < ActiveRecord::Base

    # -------------------------------------------------------------------------
    # Class Methods
    # -------------------------------------------------------------------------

    def self.search(a_query)
      select(
        'karaokes.*',
        "MATCH(title, author) AGAINST ('#{a_query}'  IN NATURAL LANGUAGE MODE) AS score"
      ).includes(
        :tags
      ).where(
        "MATCH(title, author) AGAINST (? IN NATURAL LANGUAGE MODE)",
        "#{a_query}"
      ).order("score DESC")
    end

    def self.create_from(params)
      create(
        year: params[:year],
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

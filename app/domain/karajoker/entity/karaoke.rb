module Karajoker::Entity
  class Karaoke < ActiveRecord::Base
    def self.search(a_query)
      select(
        'karaokes.*',
        "MATCH(title, author) AGAINST ('#{a_query}*' IN BOOLEAN MODE) AS score"
      ).includes(
        :tags
      ).where(
        'MATCH(title, author) AGAINST (? IN BOOLEAN MODE) > 0.001',
        "#{a_query}*"
      ).order('score DESC')
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

    has_and_belongs_to_many :tags
  end
end

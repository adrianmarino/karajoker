class Karaoke < ActiveRecord::Base

	# -------------------------------------------------------------------------
	# Class Methods
	# -------------------------------------------------------------------------

	def self.search(a_query)
 		self.includes(:tags).where("title LIKE ? ", "%#{a_query}%")
	end

	def self.create_from(params)
		self.create(title:params[:title], youtube_id: params[:youtube_id], tags: Tag.find_by_names(params[:tags]))
	end

	# -------------------------------------------------------------------------
	# Associations...
	# -------------------------------------------------------------------------

	has_and_belongs_to_many :tags

end

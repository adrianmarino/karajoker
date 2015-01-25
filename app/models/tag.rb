class Tag < ActiveRecord::Base

	# -------------------------------------------------------------------------
	# Class Methods
	# -------------------------------------------------------------------------

	def self.find_by_names(names)
		names.to_a.collect {|a_tag_name| find_by name: a_tag_name }
	end

	# -------------------------------------------------------------------------
	# Associations
	# -------------------------------------------------------------------------

	has_and_belongs_to_many :karaokes

end

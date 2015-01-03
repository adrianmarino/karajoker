class KaraokeTagRelation < ActiveRecord::Migration
  def change
	create_table 'karaokes_tags', :id => false do |t|
		t.column :karaoke_id, :integer
	    t.column :tag_id, :integer
	end
  end
end

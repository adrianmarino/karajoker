class AddYoutubeIdIndexToKaraokes < ActiveRecord::Migration
  def change
  	add_index :karaokes, :youtube_id, unique: true
  end
end

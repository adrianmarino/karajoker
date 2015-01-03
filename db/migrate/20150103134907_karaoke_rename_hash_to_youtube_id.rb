class KaraokeRenameHashToYoutubeId < ActiveRecord::Migration
  def change
  	rename_column :karaokes, :hash, :youtube_id
  end
end

class AddFullTextIndexToTitleAndAuthorOnKaraokes < ActiveRecord::Migration
  def up
    add_index :karaokes, [:title, :author],  name: 'karaoke_title_author', type: :fulltext
  end

  def down
    remove_index :karaokes, name: 'title_author'
  end
end

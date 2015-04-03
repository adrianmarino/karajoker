class AddAuthorToKaraoke < ActiveRecord::Migration
  def change
    add_column :karaokes, :author, :string
  end
end

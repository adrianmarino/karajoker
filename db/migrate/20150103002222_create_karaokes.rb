class CreateKaraokes < ActiveRecord::Migration
  def change
    create_table :karaokes do |a|
      a.string :title
      a.string :hash
      a.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |a_table|
      a_table.string :name
      a_table.timestamps
    end
  end
end

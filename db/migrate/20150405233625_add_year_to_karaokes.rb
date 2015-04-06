class AddYearToKaraokes < ActiveRecord::Migration
  def change
    add_column :karaokes, :year, :integer
  end
end

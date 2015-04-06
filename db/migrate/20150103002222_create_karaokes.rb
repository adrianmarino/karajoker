class CreateKaraokes < ActiveRecord::Migration
  def change
    create_table :karaokes, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |a|
      a.string :title
      a.string :hash
      a.timestamps
    end
  end
end

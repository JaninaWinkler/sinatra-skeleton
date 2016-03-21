class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :author
      t.string :title
      t.string :artist_name
      t.string :url
      
      t.timestamps
    end
  end
end
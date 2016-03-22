class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :content
      t.references :track
      t.references :user    
      t.timestamps
    end
  end
end

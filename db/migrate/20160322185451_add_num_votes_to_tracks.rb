class AddNumVotesToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :num_votes, :integer, default: 0 
  end
end

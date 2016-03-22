class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validate :can_only_upvote_once 
  after_create :increase_track_upvotes

  def can_only_upvote_once
    unless Upvote.where(user_id: self.user_id, track_id: self.track_id).empty?
      errors.add(:user_id, "can only upvote once.")
    end 
  end

  def increase_track_upvotes
    self.track.num_votes += 1
    self.track.save
  end

end
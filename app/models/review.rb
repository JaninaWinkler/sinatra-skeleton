class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validates :rating, presence:true, numericality: { only_integer: true }, inclusion: { in: 1..5 }
  validate :can_only_review_once

  after_create :add_review_to_track

  def can_only_review_once
    unless Review.where(user_id: self.user_id, track_id: self.track_id).empty?
      errors.add(:user_id, "can only review the track once.")
    end 
  end

  def add_review_to_track
    self.track.reviews << self
    self.track.save
  end

end
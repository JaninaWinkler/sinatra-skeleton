class User < ActiveRecord::Base

  has_many :tracks
  has_many :upvotes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

end
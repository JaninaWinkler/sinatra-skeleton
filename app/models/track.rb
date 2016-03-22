class Track < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :artist_name, presence: true
  validates :url, allow_blank: true, format: { with: /#{URI::regexp(%w(http https))}/ } if :url

end
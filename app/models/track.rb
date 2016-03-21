
class Track < ActiveRecord::Base

  validates :title, presence: true
  validates :author, presence: true
  validates :url, allow_blank: true, format: { with: /#{URI::regexp(%w(http https))}/ } if :url

end
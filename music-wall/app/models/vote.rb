class Vote < ActiveRecord::Base
  
  validates :user_id, presence: true
  validates :song_id, presence: true
  belongs_to :song
  belongs_to :user

end
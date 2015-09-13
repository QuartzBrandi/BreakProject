class Player < ActiveRecord::Base
  has_many :playtimes, :dependent => :destroy
  has_many :games, through: :playtimes

  validates_uniqueness_of :steamid
end

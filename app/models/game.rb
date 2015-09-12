class Game < ActiveRecord::Base
  has_many :playtimes
  has_many :players, through: :playtimes

  validates_uniqueness_of :appid
end

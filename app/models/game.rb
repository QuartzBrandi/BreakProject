class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  validates_uniqueness_of :appid
end

class Team < ApplicationRecord

  has_many :games
  delegate :competition, to: :games, allow_nil: true
end

class Team < ApplicationRecord

  has_many :games 
  delegate :competition, to: :games, allow_nil: true
  has_many :standings, dependent: :destroy, inverse_of: :team
end

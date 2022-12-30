class Game < ApplicationRecord
    has_many :teams
    belongs_to :competition
end

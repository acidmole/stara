class Game < ApplicationRecord
    has_many :teams inverse_of: :game
    belongs_to :competition
end

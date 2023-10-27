class Competition < ApplicationRecord
    has_many :games, inverse_of: :competition
    has_many :teams, through: :games
    belongs_to :standing

    def to_s
        self.name
    end
end

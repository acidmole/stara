class Competition < ApplicationRecord
    has_many :games
    has_many :teams, through: :games
    belongs_to :standing

    def to_s
        self.name
    end
end

class Competition < ActiveRecord::Base
    has_many :games, inverse_of: :competition, dependent: :destroy
    has_many :teams, through: :games
    has_many :standings
    has_many :results, through: :games

    scope :active, -> { where(active: true) }
end

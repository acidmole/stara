class Competition < ActiveRecord::Base
    has_many :games, inverse_of: :competition
    has_many :teams, through: :games
    has_many :standings



end

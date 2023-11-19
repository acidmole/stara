class Game < ActiveRecord::Base
    has_many :teams, inverse_of: :game
    belongs_to :competition
    has_one :result, dependent: :destroy

    def home_team
        Team.find(self.home_team_id)
    end

    def away_team
        Team.find(self.away_team_id)
    end

    def teams
        [self.home_team, self.away_team]
    end

end

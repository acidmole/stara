class Team < ActiveRecord::Base

  has_many :standings
  has_many :games, inverse_of: :team
  has_many :competitions, through: :game
  has_many :rosters, inverse_of: :team
  has_many :results

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def find_or_create_team(id, name)
    team = Team.find_by(id: id)
    if team.nil?
      team = Team.create(id: id, name: name)
    end
    team
  end
end

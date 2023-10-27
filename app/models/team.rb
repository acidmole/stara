class Team < ActiveRecord::Base

  has_many :standings
  has_many :games, inverse_of: :team
  has_many :competitions, through: :game

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

end

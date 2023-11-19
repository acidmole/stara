class RemoveScoreColumnsFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :home_team_score
    remove_column :games, :away_team_score
  end
end

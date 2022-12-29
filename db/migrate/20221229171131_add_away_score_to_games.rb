class AddAwayScoreToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :away_score, :integer
  end
end

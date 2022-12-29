class AddHomeScoreToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :home_score, :integer
  end
end
